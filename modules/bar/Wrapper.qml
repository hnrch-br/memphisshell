import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services
import qs.modules.bar.components

Item {
    id: wrapperRoot

    required property bool peeking
    required property real barHeight

    required property bool pinned
    signal pinToggled()

    required property bool launcher
    signal launcherToggled()

    readonly property bool hovered: itemHover.hovered || rectHover.hovered
    property alias handlerItem: handler
    property alias barItem: bar

    Item {
        id: handler
        implicitWidth: wrapperRoot.peeking || wrapperRoot.pinned ? 44 : 5
        implicitHeight: wrapperRoot.barHeight
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }

        HoverHandler {
            id: itemHover
        }
    }

    Rectangle {
        id: bar
        implicitWidth: 44
        implicitHeight: wrapperRoot.barHeight

        color: Colors.color9
        bottomRightRadius: 3
        topRightRadius: 3

        anchors.verticalCenter: parent.verticalCenter

        state: wrapperRoot.pinned ? "pinned" : wrapperRoot.peeking ? "peeking" : "hidden"

        HoverHandler {
            id: rectHover
        }

        TopSection {
            pinned: wrapperRoot.pinned
            launcher: wrapperRoot.launcher
            onPinClicked: wrapperRoot.pinToggled()
            onLauncherClicked: wrapperRoot.launcherToggled()
        }

        MiddleSection {}

        BottomSection {}

        states: [
            State {
                name: "pinned"
                AnchorChanges {
                    target: bar
                    anchors.left: parent.left
                    anchors.right: undefined
                }
            },
            State {
                name: "peeking"
                AnchorChanges {
                    target: bar
                    anchors.left: parent.left
                    anchors.right: undefined
                }
            },
            State {
                name: "hidden"
                AnchorChanges {
                    target: bar
                    anchors.left: undefined
                    anchors.right: parent.left
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "*"
                AnchorAnimation {
                    duration: 180
                    easing.type: Easing.InCubic
                }
            }
        ]
    }
}
