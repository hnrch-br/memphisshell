import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import QtCore
import Quickshell
import Quickshell.Widgets

import qs.services

ColumnLayout {
    id: optItem
    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    Layout.leftMargin: 10 

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
                    color: Qt.lighter(Colors.color13, 1.4)
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
                    color: Qt.lighter(Colors.color4, 1.4)
                    verticalAlignment: Text.AlignBottom
                }
            }
        }
    }

    RowLayout {
        spacing: 6
        GridLayout {
            OptionButton {
                iconSource: Qt.resolvedUrl(`../../../assets/icons/launcher/${Network.netIcon}.svg`)
                functBool: Network.wirelessConnected || Network.wiredConnected

                onClicked: Network.toggleNet()
            }
            OptionButton {
                iconSource: Qt.resolvedUrl(`../../../assets/icons/launcher/${Bluetooth.btIcon}.svg`)
                functBool: Bluetooth.enabled

                onClicked: Bluetooth.toggleEnabled()
            }
            OptionButton {}
            OptionButton {}

            rowSpacing: 6
            columnSpacing: 6
            columns: 2
        }
        OptionSlider {
            value: Audio.sinkVolume
            onMoved: Audio.setSinkVolume(value)

            iconSource: Qt.resolvedUrl("../../../assets/icons/launcher/sink.svg")
        }
        OptionSlider {
            value: Audio.sourceVolume
            onMoved: Audio.setSourceVolume(value)

            iconSource: Qt.resolvedUrl("../../../assets/icons/launcher/source.svg")
        }
    }

    component OptionButton: Button {
        id: optButton
        background: Item {
            id: buttonItem
            implicitWidth: Math.floor((launcherRect.implicitWidth - 40) / 4)
            implicitHeight: 54
            ClippingRectangle {
                implicitWidth: optButton.down ? buttonItem.implicitWidth - 4 : buttonItem.implicitWidth
                implicitHeight: optButton.down ? buttonItem.implicitHeight - 2 : buttonItem.implicitHeight

                anchors.centerIn: parent

                color: optButton.functBool ? Colors.color7 : Qt.darker(Colors.color7, 1.4)
                radius: 3
            }
        }
        property string iconSource: ""
        property bool functBool: false

        HoverHandler {
            id: hover
            cursorShape: Qt.PointingHandCursor
        }

        IconImage {
            source: optButton.iconSource
            implicitSize: 35
            anchors.centerIn: parent
            backer.smooth: true
            backer.layer.enabled: true
            backer.layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: Colors.background
            }
        }
    }

    component OptionSlider: Slider {
        id: slider
        orientation: Qt.Vertical
        from: 0
        to: 1.0
        snapMode: Slider.SnapAlways
        stepSize: 0.05

        property string iconSource: ""

        handle: Rectangle {
            implicitHeight: 20
            implicitWidth: Math.floor((launcherRect.implicitWidth - 40) / 4)
            topLeftRadius: 3
            topRightRadius: 3
            color: Colors.foreground
            x: slider.leftPadding + (slider.availableWidth - width) / 2
            y: slider.topPadding + slider.visualPosition * (slider.availableHeight - height)
        }

        background: Rectangle {
            id: sliderBg
            implicitHeight: 114
            height: slider.availableHeight
            implicitWidth: Math.floor((launcherRect.implicitWidth - 2 * 54) / 4)
            radius: 3
            color: Qt.darker(Colors.foreground, 1.4)

            x: slider.leftPadding
            y: slider.topPadding + (slider.availableHeight - height) / 2

            Rectangle {
                width: parent.width
                height: parent.height * slider.position
                color: Colors.foreground
                radius: 3

                anchors.bottom: parent.bottom
            }
        }

        IconImage {
            z: 2
            source: slider.iconSource
            implicitSize: 30
            backer.smooth: true
            backer.layer.enabled: true
            backer.layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: Colors.background
            }

            anchors {
                bottom: parent.bottom
                bottomMargin: 8
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
