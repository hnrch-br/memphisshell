import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets

import qs.services

ClippingRectangle {
    id: wsRoot
    Layout.alignment: Qt.AlignHCenter

    implicitWidth: 32
    implicitHeight: wsCol.implicitHeight + 20

    color: Colors.color15
    radius: 4

    property real wheelAccumulator: 0

    Timer {
        id: wsWheelTimer
        interval: 200
        onTriggered: wsRoot.wheelAccumulator = 0
    }

    WheelHandler {
        acceptedModifiers: Qt.NoModifier
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: wheel => {
            wsWheelTimer.restart();
            wsRoot.wheelAccumulator -= wheel.angleDelta.y;

            const threshold = 120;
            if (Math.abs(wsRoot.wheelAccumulator) < threshold)
                return;

            const steps = Math.trunc(wsRoot.wheelAccumulator / threshold);
            wsRoot.wheelAccumulator = wsRoot.wheelAccumulator % threshold;

            const list = Hypr.workspaces ?? [];
            const count = list.length;
            if (count <= 1)
                return;

            let curIdx = list.findIndex(w => w.id === Hypr.focusedId);
            if (curIdx < 0)
                curIdx = steps > 0 ? count - 1 : 0;

            const nextIdx = ((curIdx + steps) % count + count) % count;
            const idx = list[nextIdx].id;

            if (idx !== Hypr.focusedId) {
                Hypr.focusWorkspace(idx);
            }
        }
    }

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    ColumnLayout {
        id: wsCol
        spacing: 2

        anchors.fill: parent
        anchors.bottomMargin: 5
        anchors.topMargin: 5

        Repeater {
            model: ScriptModel {
                values: Hypr.workspaces
            }
            delegate: Item {
                id: wsItem

                required property var modelData
                readonly property real rectSize: 24
                implicitWidth: wsItem.rectSize
                implicitHeight: wsItem.rectSize

                Layout.alignment: Qt.AlignHCenter

                TapHandler {
                    acceptedModifiers: Qt.NoModifier
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    onTapped: Hypr.focusWorkspace(wsItem.modelData.id)
                }

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }

                ClippingRectangle {
                    id: wsRect

                    property bool focused: wsItem.modelData.id === Hypr.focusedId

                    anchors.centerIn: parent

                    radius: wsRect.focused ? 3 : 1

                    color: Qt.darker(Colors.color14, 1.2)

                    implicitWidth: wsRect.focused ? wsItem.rectSize : 10
                    implicitHeight: wsRect.focused ? wsItem.rectSize : 6

                    Behavior on implicitWidth {
                        NumberAnimation {
                            duration: 180
                            easing.type: Easing.OutCubic
                        }
                    }
                    Behavior on implicitHeight {
                        NumberAnimation {
                            duration: 180
                            easing.type: Easing.OutCubic
                        }
                    }
                    Behavior on radius {
                        NumberAnimation {
                            duration: 180
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }
    }
}
