import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.services
import qs.modules.bar as Bar
import qs.modules.launcher as Launcher

Variants {
    model: Quickshell.screens
    Scope {
        id: root
        required property ShellScreen modelData

        PanelWindow {
            id: panel

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            property bool launcher: false
            property bool pinned: false

            property bool peeking: false
            readonly property bool hovered: barWrapper.hovered || launchWrapper.hovered
            readonly property bool barVisible: peeking || pinned

            onHoveredChanged: {
                if (panel.hovered) {
                    panel.peeking = true;
                } else {
                    panel.peeking = false;
                }
            }

            onBarVisibleChanged: {
                if (!barVisible) {
                    launcher = false;
                }
            }

            implicitWidth: 500

            screen: root.modelData

            color: "transparent"

            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.keyboardFocus: panel.launcher ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
            exclusionMode: ExclusionMode.Ignore

            property real barHeight: panel.screen.height * 0.86

            mask: Region {
                Region {
                    item: barWrapper.barItem
                }
                Region {
                    item: barWrapper.handlerItem
                }
                Region {
                    item: launchWrapper.launcherItem
                }
            }

            Bar.Wrapper {
                id: barWrapper

                anchors.fill: parent

                pinned: panel.pinned
                launcher: panel.launcher
                peeking: panel.peeking
                barHeight: panel.barHeight
                onPinToggled: panel.pinned = !panel.pinned
                onLauncherToggled: panel.launcher = !panel.launcher
            }

            Launcher.Wrapper {
                id: launchWrapper

                launcher: panel.launcher
                barHeight: panel.barHeight
                barItem: barWrapper.barItem
            }
        }

        PanelWindow {
            screen: root.modelData
            anchors.left: true
            implicitWidth: 1
            implicitHeight: 1
            color: "transparent"
            exclusiveZone: panel.pinned ? 38 : 0
            mask: Region {}
        }
    }
}
