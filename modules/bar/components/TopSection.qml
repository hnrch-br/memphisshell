import QtQuick
import QtQuick.Layouts

import qs.modules.bar.widgets

ColumnLayout {
    id: topRoot
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 5
    }

    PinButton {
        pinned: topRoot.pinned
        onClicked: topRoot.pinClicked()
    }

    LauncherButton {
        launcher: topRoot.launcher
        onClicked: topRoot.launcherClicked() && topRoot.pinClicked()
    }

    signal pinClicked
    signal launcherClicked
    property bool pinned
    property bool launcher
}
