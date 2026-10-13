import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Effects

import qs.services

Button {
    id: launchRoot

    background: Item {
        implicitWidth: 32
        implicitHeight: 32

        Rectangle {
            implicitWidth: launchRoot.down ? 30 : 32
            implicitHeight: launchRoot.down ? 30 : 32

            anchors.centerIn: parent

            color: launchRoot.down ? Qt.darker(Colors.color7, 1.1) : Colors.color7
            radius: 3

            Behavior on color {
                ColorAnimation {
                    duration: 100
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }

    Layout.alignment: Qt.AlignHCenter

    property bool launcher

    IconImage {
        source: Qt.resolvedUrl("../../../assets/icons/bar/nixos.svg")
        implicitSize: 28
        anchors.centerIn: parent
        backer.smooth: true
        backer.layer.enabled: true
        backer.layer.effect: MultiEffect {
            colorization: 1.0
            colorizationColor: Colors.background
        }
        rotation: launchRoot.launcher ? 360 : 0
        Behavior on rotation {
            NumberAnimation {
                duration: 160
                easing.type: Easing.OutCubic
            }
        }
    }
}
