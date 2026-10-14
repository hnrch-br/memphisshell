import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets

import qs.services

TextField {
    id: searchField
    required property bool launcher
    required property string input

    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

    background: ClippingRectangle {
        id: searchBox
        implicitWidth: launcherRect.implicitWidth - 20
        implicitHeight: 50

        radius: 3
        color: Colors.color7

        Rectangle {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }

            implicitWidth: searchBox.implicitWidth
            implicitHeight: 3
            radius: 1

            color: Qt.darker(Colors.color7, 1.8)
        }
    }

    placeholderText: "search"
    placeholderTextColor: Qt.alpha(Colors.background, 0.6)
    font {
        family: "Monocraft"
        styleName: "Regular"
        pixelSize: 15
    }
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter
    leftPadding: 8

    onLauncherChanged: searchField.text = ""
}
