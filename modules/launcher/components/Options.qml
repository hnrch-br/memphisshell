import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtCore
import Quickshell
import Quickshell.Widgets

import qs.services

ColumnLayout {
    id: optItem
    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

    spacing: 10

    RowLayout {
        spacing: 10
        Item {
            implicitWidth: 32
            implicitHeight: 32
            Button {
                id: iconButton
                anchors.centerIn: parent
                background: ClippingRectangle {
                    implicitWidth: iconButton.down ? 30 : 32
                    implicitHeight: iconButton.down ? 30 : 32

                    radius: 9999

                    color: Colors.color3

                    Image {
                        z: 2
                        anchors.fill: parent
                        source: Quickshell.env("HOME") + "/Pictures/binturong.jpg"
                        mipmap: true
                    }

                    HoverHandler {
                        id: iconHover
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }

        Item {
            RowLayout {
                spacing: 6
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: username
                    text: Quickshell.env("USER")
                    font {
                        family: "Pixelify Sans"
                        styleName: "Regular"
                        pixelSize: 18
                    }
                    color: Colors.foreground
                    verticalAlignment: Text.AlignBottom
                }
                Text {
                    text: "at"
                    font {
                        family: "Bytesized"
                        styleName: "Regular"
                        pixelSize: 20
                    }
                    color: Qt.lighter(Colors.color10, 1.5)
                    verticalAlignment: Text.AlignBottom
                }
                Text {
                    text: SystemInformation.machineHostName
                    font {
                        family: "Pixelify Sans"
                        styleName: "Regular"
                        pixelSize: 18
                    }
                    color: Colors.foreground
                    verticalAlignment: Text.AlignBottom
                }
            }
        }
    }

    GridLayout {

        OptionButton {}
        OptionButton {}
        OptionButton {}
        OptionButton {}

        rowSpacing: 10
        columnSpacing: 10
        columns: 2

        Layout.alignment: Qt.AlignHCenter

        component OptionButton: Item {
            id: buttonItem
            implicitWidth: Math.floor((launcherRect.implicitWidth - 40)/2)
            implicitHeight: 48
            Button {
                id: optButton
                background: ClippingRectangle {
                    implicitWidth: optButton.down ? buttonItem.implicitWidth - 4 : buttonItem.implicitWidth
                    implicitHeight: optButton.down ? buttonItem.implicitHeight - 2 : buttonItem.implicitHeight

                    color: Qt.darker(Colors.color7, 1.4)
                    radius: 3
                }

                anchors.centerIn: parent
            
                HoverHandler {
                    id: hover
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
