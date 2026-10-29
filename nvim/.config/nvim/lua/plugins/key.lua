local whichkey_opt = {
	delay = 300,
	preset = 'helix',
	show_help = false,
	win = {
		height = { min = 4, max = 30 },
		width = 40,
		border = "single",
		padding = { 0, 1 },
		title = true,
		title_pos = "left",
	},
	icons = {
		breadcrumb = "",
		separator = "→",
		group = "",
		mappings = false,
	},
}

local function vimpack_setup_jieba()
	vim.g.jieba_vim_keymap = 1
	vim.g.jieba_vim_lazy = 1

	vim.pack.add({
		{ src = "https://github.com/kkew3/jieba.vim" }
	})

	local so_path = vim.fn.stdpath("data")
		.. "/site/pack/core/opt/jieba.vim"
		.. "/lua/jieba_vim/jieba_vim_rs.so"

	if vim.uv.fs_stat(so_path) then return end

	if vim.fn.executable("cargo") ~= 1 then return end

	vim.cmd("call jieba_vim#install()")
end

local function vimpack_setup_whichkey()
	vim.pack.add({
		{ src = "https://github.com/folke/which-key.nvim" }
	})
	require("which-key").setup(whichkey_opt)
end

local function lazy_setup_whichkey()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_whichkey()
	vimpack_setup_jieba()
else
	lazy_setup_whichkey()
end

vim.keymap.set('n', '<leader>kk', '<CMD>WhichKey<CR>', { desc = 'View keymap' })
