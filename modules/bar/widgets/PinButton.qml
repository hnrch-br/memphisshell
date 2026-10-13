import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.Widgets

import qs.services

Button {
    id: pinRoot

    background: Item {

        implicitWidth: 20
        implicitHeight: 20

        Rectangle {
            implicitWidth: pinRoot.down ? 18 : 20
            implicitHeight: pinRoot.down ? 18 : 20

            anchors.centerIn: parent

            color: pinRoot.down ? Qt.darker(Colors.color7, 1.1) : Colors.color7
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
    property bool pinned

    IconImage {
        source: Qt.resolvedUrl("../../../assets/icons/bar/pin.svg")
        implicitSize: 16
        anchors.centerIn: parent
        backer.smooth: true
        backer.layer.enabled: true
        backer.layer.effect: MultiEffect {
            colorization: 1.0
            colorizationColor: Colors.background
        }
        rotation: pinRoot.pinned ? 0 : 45
        Behavior on rotation {
            NumberAnimation {
                duration: 160
                easing.type: Easing.OutCubic
            }
        }
    }
}
