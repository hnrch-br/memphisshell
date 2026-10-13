pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int cpuUsage: 0
    property int memUsage: 0
    property int gpuUsage: 0

    Process {
        id: cpuProc
        command: ["sh" , "-c", "vmstat 1 2 | tail -1 | awk '{print 100-$15}'"]
        stdout: SplitParser {
            onRead: data => {
                if (data) return
                    root.cpuUsage = parseInt(data);
            }
        }
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | awk '/^Mem:/ {printf \"%.1f\", ($2-$7)/$2*100}'"]
        stdout: SplitParser {
            onRead: data => {
                if (data) return
                    root.memUsage = parseInt(data);
            }
        }
    }

    Process {
        id: gpuProc
        command: ["sh", "-c", `cat /sys/class/drm/card1/device/gpu_busy_percent`]
        stdout: SplitParser {
            onRead: data => {
                if (data) return
                    root.gpuUsage = parseInt(data);
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
            gpuProc.running = true
        }
    }
}
