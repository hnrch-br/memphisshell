pragma ComponentBehavior: Bound

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
            anchors {
                fill: parent
                leftMargin: 3
                topMargin: 15
                bottomMargin: 15
            }
            spacing: 2

            Options {}

            ColumnLayout {
                spacing: 10

                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                SearchBar {
                    launcher: wrapperRoot.launcher
                    input: wrapperRoot.input
                }
                List {
                    launcher: wrapperRoot.launcher
                }
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
                from: "deactivated"
                to: "activated"
                SequentialAnimation {
                    PropertyAction {
                        target: launcherRect
                        property: "visible"
                        value: true
                    }
                    NumberAnimation {
                        target: launcherRect
                        property: "implicitWidth"
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            },
            Transition {
                from: "activated"
                to: "deactivated"
                SequentialAnimation {
                    NumberAnimation {
                        target: launcherRect
                        property: "implicitWidth"
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                    PropertyAction {
                        target: launcherRect
                        property: "visible"
                        value: false
                    }
                }
            }
        ]
    }
}
