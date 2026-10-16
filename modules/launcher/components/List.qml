pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services

Item {
    id: listItem
    required property bool launcher
    required property string input

    implicitWidth: launcherRect.implicitWidth - 20
    implicitHeight: launcherRect.implicitHeight - 270

    property var apps: {
        DesktopEntries.applications.values
            .filter(a => !a.noDisplay)
            .sort((a, b) => a.name.localeCompare(b.name))
    }

    readonly property var filtered: {
        const q = input.trim();

        return listItem.apps
            .map(a => ({
                app: a,
                score: Math.max(
                    listItem.fuzzyMatch(q, a.name),
                    listItem.fuzzyMatch(q, a.genericName) * 0.8,
                    listItem.fuzzyMatch(q, a.comment) * 0.5
                )
            }))
            .filter(r => r.score >= 0)
            .sort((a, b) => b.score - a.score)
            .map(r => r.app);
    }

    function fuzzyMatch(qry, text) {
        if (!text) return -1;

        var qidx = 0, score = 0, init = -1;
        const txt = text.toLowerCase();
        qry = qry.toLowerCase()

        for (var tidx = 0;  tidx < txt.length && qidx < qry.length; tidx++) {
            if (txt[tidx] !== qry[qidx]) continue;
            score += 1;
            if (init === tidx - 1) score += 3;
            if (tidx === 0 || " -_.".includes(txt[tidx - 1])) score += 5;
            init = tidx;
            qidx++;
        }
        if (qidx < qry.length) return -1;
        if (txt.startsWith(qry)) score += 10;
        else if (txt.includes(qry)) score += 5;
        return score - txt.length * 0.01;
    }

    ClippingRectangle {
        id: listBg
        implicitWidth: listItem.implicitWidth
        implicitHeight: listItem.implicitHeight

        color: Qt.darker(Colors.color1, 1.5)
        radius: 3

        ListView {
            anchors.fill: parent
            clip: true
            model: ScriptModel {
                values: listItem.filtered
            }
            spacing: 5

            anchors.leftMargin: 4
            anchors.rightMargin: 4
            anchors.topMargin: 4
            anchors.bottomMargin: 4

            delegate: Item {
                id: delegateItem
                required property var modelData
                required property int index

                implicitWidth: ListView.view.width
                implicitHeight: 50

                Button {
                    id: itemButton
                    background: Rectangle {
                        implicitWidth: itemButton.down ? delegateItem.implicitWidth - 4 : delegateItem.implicitWidth
                        implicitHeight: itemButton.down ? delegateItem.implicitHeight - 2 : delegateItem.implicitHeight

                        radius: 3
                        color: hover.hovered ? Qt.darker(Colors.color1, 1.8) : Colors.color1
                    }
                    anchors.centerIn: parent

                    HoverHandler {
                        id: hover
                        cursorShape: Qt.PointingHandCursor
                    }

                    RowLayout {
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: 5
                            right: parent.right
                            rightMargin: 5
                        }
                        Text {
                            text: delegateItem.modelData.name
                            font {
                                family: "Monocraft"
                                styleName: "Regular"
                                pixelSize: 14
                            }
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                            color: Colors.foreground
                        }
                    }

                    onClicked: delegateItem.modelData.execute()
                }
            }
        }
    }
}
