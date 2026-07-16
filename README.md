# OliverChase's dotfiles

## 配置说明

### alacritty/
1. 终端: Alacritty
2. 字体: Literation Mono Nerd Font 17pt
3. 主题: Catppuccin Mocha
4. 窗口: 无装饰、启动最大化、20px 内边距
5. 快捷键: Ctrl+Shift+C/V 复制粘贴, Ctrl+Shift+N 新窗口
6. 配置拆分: font.toml / window.toml / colors.toml / input.toml

### bash/
1. 别名: nvim, yazi, git, cd 等...
2. 环境变量: path, qt-theme, rust/cargo, nodejs ...
3. 功能函数: fzf 快捷键
4. 命令补全: 常规补全，opencode 补全
5. 自动 tmux: 未在 tmux 中时自动 attach 或新建会话

### btop/
1. 添加 Catppuccin Mocha 主题

### git/
1. 配置别名
2. 使用 gh 凭证: gh auth git-credential（GitHub/Gist）

### kitty/
1. 字体: Liberation Mono 17pt
2. 主题: Catppuccin Mocha
3. 其他设置: 禁用粘贴确认、禁用 shell 光标集成

### nodejs/
1. 代理: http://127.0.0.1:7897
2. 前缀: ~/.local（全局安装路径）
3. 缓存: ~/.cache/npm

### not_stow/
1. 浏览器: Vimium C 配置备份

### nvim/
1. 选项: 相对行号、光标行高亮、tabstop=4 等
2. 插件管理: nvim≥0.12 用 vim.pack, 否则 lazy.nvim（未完成）
3. 主题: Catppuccin Mocha
4. 核心插件: alpha、oil、telescope、bufferline、lualine、which-key、blink、treesitter（高亮）
5. LSP/DAP/格式化: Mason 管理 LSP/DAP；支持 debugpy、codelldb、gdb 调试；conform 插件补全
6. Markdown: render-markdown（图标+边框+表格）、image.nvim（Kitty 内联图片）
7. csv: 支持 csv 预览。
8. 自动命令: 通过 D-Bus 自动切换中英文输入法；自动关闭空缓冲区
9. 按键: 窗口导航；终端启动；插件快捷键

### opencode/
1. 默认 agent: plan
2. 权限: bash/edit/task/webfetch 允许, edit 需确认
3. 自动更新: 禁用
4. TUI: catppuccin 主题, ctrl+x leader, alt+e 编辑器
5. 规则: 中文沟通、最小修改、不自动 commit

### python/
预留给 pip 配置，当前为空

### rime-wanxiang/
1. 快捷键配置
2. 水平显示候选栏

### rust/
预留给 Cargo 配置，当前为空

### tmux/
1. 前缀: C-Space
2. 索引: 窗口/面板从 1 开始
3. 鼠标: 启用, set-clipboard on
4. 主题: Catppuccin Mocha 配色
5. 状态栏: 底部, 日期/时间/前缀指示
6. 导航: h/j/k/l 选面板, ./, 切换窗口, n 新建, x 关闭
7. 分割: v 垂直 / c 水平 / d 关闭面板
8. 复制: vi 模式, wl-copy（Wayland）

### typora/
1. 主题: resume.css（简历使用的主题）

### yazi/
1. 主题: catppuccin
2. 基本设置: 排序方式，默认显示隐藏

## todo

### nvim
1. 配置 lazy.nvim 插件管理兼容
