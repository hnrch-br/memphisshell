pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets

import qs.services

TextField {
    id: searchField
    required property bool launcher
    required property string input

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
 
    cursorDelegate: Rectangle {
        id: cursorDelegate
        implicitWidth: 2
        implicitHeight: 15

        color: Qt.alpha(Colors.background, 0.6)

        Timer {
            id: blinkTimer
            interval: 600
            running: true
            repeat: true
            onTriggered: cursorDelegate.visible = !cursorDelegate.visible
        }
        
        Timer {
            id: idleBlinkTimer
            interval: 500
            onTriggered: blinkTimer.start()
        }

        function resetBlink(): void {
            blinkTimer.stop();
            cursorDelegate.visible = true;
            idleBlinkTimer.restart();
        }

        Connections {
            target: searchField

            function onTextChanged() {
                cursorDelegate.resetBlink();
            }

            function onCursorPositionChanged() {
                cursorDelegate.resetBlink();
            }
        }
    }
}
