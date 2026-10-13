//@ pragma Env QT_SCALE_FACTOR=1
//@ pragma UseQApplication
//@ pragma DefaultEnv QS_DROP_EXPENSIVE_FONTS=1
//@ pragma DefaultEnv QSG_RENDER_LOOP=threaded
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma IconTheme WhiteSur-Dark
//@ pragma Env QS_ICON_THEME = WhiteSur-Dark
//@ pragma DefaultEnv QT_QUICK_FLICKABLE_WHEEL_DECELERATION=5000

import Quickshell
import qs.modules as Modules

ShellRoot {
    Modules.Window {}
}
