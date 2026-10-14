pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.services

Rectangle {
    id: listBg
    required property bool launcher
    implicitWidth: launcherRect.implicitWidth - 20
    implicitHeight: launcherRect.implicitHeight - 270

    color: Qt.darker(Colors.color1, 1.5)
    radius: 3

    ListView {
        anchors.fill: parent
    }
}
