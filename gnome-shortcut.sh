## 窗口
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "[]" ## 重置快捷键（禁用）
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]" ## 打开通知（禁用）
gsettings set org.gnome.shell.keybindings focus-active-notification "[]" ## 显示通知列表（禁用）
gsettings set org.gnome.shell.keybindings toggle-application-view "[]" ## 显示所有应用（禁用，用win-win代替）
gsettings set org.gnome.shell.keybindings toggle-quick-settings "[]" ## 快速设置（禁用）
gsettings set org.gnome.settings-daemon.plugins.media-keys help "[]" ## 帮助（禁用）

gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "[]" ## 窗口左移显示器（禁用）
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down "[]" ## 窗口上移显示器（禁用）
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up "[]" ## 窗口下移显示器（禁用）
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "[]" ## 窗口右移显示器（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-1 "[]" ## 打开快捷栏1的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-2 "[]" ## 打开快捷栏2的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-3 "[]" ## 打开快捷栏3的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-4 "[]" ## 打开快捷栏4的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-5 "[]" ## 打开快捷栏5的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-6 "[]" ## 打开快捷栏6的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-7 "[]" ## 打开快捷栏7的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-8 "[]" ## 打开快捷栏8的应用（禁用）
gsettings set org.gnome.shell.keybindings switch-to-application-9 "[]" ## 打开快捷栏9的应用（禁用）

gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>h']" ## 左分屏
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>j']" ## 取消最大化
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>k']" ## 最大化
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super><Shift>k']" ## 最小化
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>l']" ## 右分屏
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super>c']" ## 把窗口移到中央
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']" ## toggle 全屏
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>m']" ## toggle 最大化
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>r']" ## 调整窗口大小（随后用left, down, up, right控制）
gsettings set org.gnome.desktop.wm.keybindings begin-move "[]" ## 开始移动窗口（随后用left, down, up, right控制）（禁用）

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super>0']" ## 进入第1个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>comma']" ## 进入左边工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>period']" ## 进入右边工作区
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "['<Super>e']" ## 进入最后一个工作区

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift>comma']" ## 窗口移到左边工作区
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift>period']" ## 窗口移到右边工作区
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Control><Alt>l']" ## 锁屏
gsettings set org.gnome.settings-daemon.plugins.media-keys logout "['<Control><Alt>Escape']" ## 登出



