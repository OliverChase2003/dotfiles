local treesitter_opt = 		{
	modules = {},
	ensure_installed = {
		'lua',
		'python',
		'json',
		'vim',
		'markdown',
		'rust',
		'c'
	},
	ignore_install = {},
	auto_install = true,
	sync_install = false,
	highlight = {
		enable = false,
		additional_vim_regex_highlighting = false
	},
	indent = { enable = true }
}

local function vimpack_setup_treesitter()
	vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } })

	vim.api.nvim_create_autocmd('BufReadPre', {
		group = vim.api.nvim_create_augroup("SetupTreesitter", { clear = true }),
		once = true,
		callback = function()
			require('nvim-treesitter.configs').setup(treesitter_opt)
		end,
	})
end

local function lazy_setup_treesitter()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_treesitter()
else
	lazy_setup_treesitter()
end
