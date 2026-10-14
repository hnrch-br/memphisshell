import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets

import qs.services

RowLayout {
    id: optRow

    required property bool launcher

    Layout.alignment: Qt.AlignHCenter

    property var options: [
        {
            name: "App"
        },
        {
            name: "Clip"
        },
        {
            name: "Calc"
        }
    ]

    OptionRectangle {}
    OptionRectangle {}
    OptionRectangle {}

    spacing: 10

    component OptionRectangle: Item {
        id: optItem
        implicitWidth: Math.floor((launcherRect.implicitWidth - 2*2*10)/3)
        implicitHeight: 45

        Button {
            id: optButton
            
            anchors.centerIn: parent

            background: ClippingRectangle {
                id: buttonBg

                implicitWidth: optButton.down ? optItem.implicitWidth - 4 : optItem.implicitWidth
                implicitHeight: optButton.down ? optItem.implicitHeight - 2 : optItem.implicitHeight
                radius: 3

                color: optButton.hovered ? Qt.darker(Colors.color9, 0.8) : Qt.darker(Colors.color9, 1.6)

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                        easing.type: Easing.InCubic
                    }
                }

                Rectangle {
                    implicitWidth: buttonBg.implicitWidth
                    implicitHeight: 3
                    radius: 3

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                    }

                    color: Colors.color14
                }
            }

            hoverEnabled: true
        }
    }
}
