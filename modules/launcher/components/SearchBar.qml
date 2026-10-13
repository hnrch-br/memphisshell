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
    Layout.topMargin: 10

    background: Rectangle {
        implicitWidth: 250
        implicitHeight: 30

        radius: 3
        color: Colors.color7
    }

    placeholderText: "search"
    placeholderTextColor: Qt.alpha(Colors.background, 0.8)
    font {
        family: "Monocraft"
        styleName: "Regular"
        pixelSize: 15
    }
    horizontalAlignment: Text.AlignHCenter

    onLauncherChanged: searchField.text = ""
}
