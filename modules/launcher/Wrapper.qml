import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import qs.services
import qs.modules.launcher.components

Item {
    id: wrapperRoot
    z: -1

    readonly property bool hovered: launcherHover.hovered
    readonly property string input: ""

    required property bool launcher
    required property real barHeight
    required property Item barItem

    property alias launcherItem: launcherRect

    implicitWidth: launcherRect.implicitWidth
    implicitHeight: wrapperRoot.barHeight

    anchors.verticalCenter: parent.verticalCenter
    x: barItem.x + barItem.width - 3

    ClippingRectangle {
        id: launcherRect

        implicitHeight: wrapperRoot.barHeight

        color: Qt.darker(Colors.color9, 1.2)
        bottomRightRadius: 3
        topRightRadius: 3

        anchors.left: parent.left

        state: wrapperRoot.launcher ? "activated" : "deactivated"

        HoverHandler {
            id: launcherHover
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.topMargin: 10
            anchors.bottomMargin: 0

            SearchBar {
                launcher: wrapperRoot.launcher
                input: wrapperRoot.input
            }
            Options {
                launcher: wrapperRoot.launcher
            }
            List {
                launcher: wrapperRoot.launcher
            }
        }

        states: [
            State {
                name: "activated"
                PropertyChanges {
                    target: launcherRect
                    implicitWidth: 300
                }
            },
            State {
                name: "deactivated"
                PropertyChanges {
                    target: launcherRect
                    implicitWidth: 3
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation {
                    target: launcherRect
                    properties: "implicitWidth"
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        ]
    }
}
