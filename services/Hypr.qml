pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    readonly property int focusedId: Hyprland.focusedWorkspace?.id ?? -1
    property var workspaces: []

    function updateWorkspace(): void {
        try {
            const value = Hyprland
                .workspaces
                .values
                .filter(workspace => workspace.id >= 0)
                .sort((a, b) => a.id - b.id);

            const base = Array.from({
                length: 5
            }, (_, i) => {
                const id = i + 1;
                return value.find(w => w.id === id) ?? {
                    id
                };
            });
            const filtering = value.filter(w => w.id > 5);

            root.workspaces = [...base, ...filtering];
        } catch (e) {
            root.workspaces = [];
        }
    }

    function focusWorkspace(id) {
        Hyprland.dispatch("hl.dsp.focus({ workspace = " + Number(id) + " })");
    }

    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() { 
            root.updateWorkspace();
        }
    }

    Component.onCompleted: updateWorkspace()
}
