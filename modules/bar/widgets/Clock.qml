import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Effects

import qs.services

Button {
    id: clockRoot
    background: Item {
        implicitHeight: 115
        implicitWidth: 36
        Rectangle {
            implicitWidth: clockRoot.down ? 34 : 36
            implicitHeight: clockRoot.down ? 113 : 115

            anchors.centerIn: parent

            color: clockRoot.down ? Qt.darker(Colors.color7, 1.1) : Colors.color7
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

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 2
        Text {
            text: Time.format("HH\nmm")
            font {
                family: "Ndot 55"
                pixelSize: 26
                styleName: "Regular"
            }
            lineHeightMode: Text.FixedHeight
            lineHeight: 28
            color: Colors.background
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
        IconImage {
            implicitSize: 28
            backer.smooth: true
            source: Weather.ready ? Qt.resolvedUrl("../../../assets/icons/weather/" + Weather.glyph(Weather.codeCur, Weather.isDay) + ".svg") : ""
            backer.layer.enabled: true
            backer.layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: Colors.background
            }
            Layout.alignment: Qt.AlignHCenter
            asynchronous: true
        }
        Text {
            text: Weather.ready ? Weather.tempCur + "°C" : "..."
            font {
                family: "Bytesized"
                pixelSize: 14
            }
            Layout.alignment: Qt.AlignHCenter
            color: Colors.background
        }
    }
}
