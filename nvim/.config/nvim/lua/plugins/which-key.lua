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

local function vimpack_setup_whichkey()
	vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } })
	require("which-key").setup(whichkey_opt)
end

local function lazy_setup_whichkey()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_whichkey()
else
	lazy_setup_whichkey()
end

vim.keymap.set('n', '<leader>wk', ':WhichKey<CR>', { desc = 'View keymap' })
