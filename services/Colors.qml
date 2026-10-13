pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    id: root

    property alias background: adapter.background
    property alias transground: adapter.transground
    property alias transground2: adapter.transground2
    property alias transground3: adapter.transground3
    property alias transground4: adapter.transground4
    property alias foreground: adapter.foreground
    property alias cursor: adapter.cursor
    property alias color0: adapter.color0
    property alias color1: adapter.color1
    property alias color2: adapter.color2
    property alias color3: adapter.color3
    property alias color4: adapter.color4
    property alias color5: adapter.color5
    property alias color6: adapter.color6
    property alias color7: adapter.color7
    property alias color8: adapter.color8
    property alias color9: adapter.color9
    property alias color10: adapter.color10
    property alias color11: adapter.color11
    property alias color12: adapter.color12
    property alias color13: adapter.color13
    property alias color14: adapter.color14
    property alias color15: adapter.color15

    FileView {
        path: Qt.resolvedUrl("./colors.json")
        watchChanges: true
        adapter: adapter
        onFileChanged: reload()
    }

    JsonAdapter {
        id: adapter
        property color background: "#060000"
        property color transground: "#33060000"
        property color transground2: "#66060000"
        property color transground3: "#AA060000"
        property color transground4: "#CC060000"
        property color foreground: "#E2E5ED"
        property color cursor: "#89909F"
        property color color0: "#070000"
        property color color1: "#74635D"
        property color color2: "#606878"
        property color color3: "#5979A5"
        property color color4: "#6E7A95"
        property color color5: "#86776C"
        property color color6: "#ABB4CB"
        property color color7: "#CDD1DD"
        property color color8: "#8F929A"
        property color color9: "#74635D"
        property color color10: "#606878"
        property color color11: "#5979A5"
        property color color12: "#6E7A95"
        property color color13: "#86776C"
        property color color14: "#ABB4CB"
        property color color15: "#CDD1DD"
    }
}
