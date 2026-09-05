## 行为
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty ## 在 kitty 打开
gsettings set org.gnome.desktop.default-applications.terminal exec 'xdg-terminal-exec' ## 默认打开终端应用的方式

gsettings set org.gnome.shell always-show-log-out true ## 显示“登出”按钮

# keymap of gnome
## 窗口
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "[]" ## 重置快捷键（禁用）
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]" ## 打开通知（禁用）
gsettings set org.gnome.shell.keybindings focus-active-notification "[]" ## 显示通知列表（禁用）
gsettings set org.gnome.shell.keybindings toggle-application-view "[]" ## 显示所有应用（禁用，用win-win代替）
gsettings set org.gnome.shell.keybindings toggle-quick-settings "[]" ## 快速设置（禁用）
gsettings set org.gnome.settings-daemon.plugins.media-keys help "[]" ## 帮助（禁用）
gsettings set org.gnome.mutter.keybindings switch-monitor "[]" ## 屏幕方案设置

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

gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>j']" ## 取消最大化
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>k']" ## 最大化
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super><Shift>k']" ## 最小化
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>h']" ## 左分屏
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>l']" ## 右分屏
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super>c']" ## 把窗口移到中央
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']" ## toggle 全屏
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>m']" ## toggle 最大化
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>r']" ## 调整窗口大小（随后用left, down, up, right控制）
gsettings set org.gnome.desktop.wm.keybindings begin-move "[]" ## 开始移动窗口（随后用left, down, up, right控制）（禁用）

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']" ## 进入第1个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']" ## 进入第2个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']" ## 进入第3个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']" ## 进入第4个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']" ## 进入第5个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']" ## 进入第6个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']" ## 进入第7个工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']" ## 进入第8个工作区

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>0']" ## 进入最左边工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>p']" ## 进入左边工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>n']" ## 进入右边工作区
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Super>e']" ## 进入最后一个工作区

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "[]" ## 进入第1个工作区
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift>p']" ## 窗口移到左边工作区
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift>n']" ## 窗口移到右边工作区
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "[]" ## 进入最后一个工作区

gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super><Alt>l']" ## 锁屏
gsettings set org.gnome.settings-daemon.plugins.media-keys logout "['<Super><Alt>Escape']" ## 登出

# input method
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>space']"
