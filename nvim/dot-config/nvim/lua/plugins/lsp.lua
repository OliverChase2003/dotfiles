-- mason lspconfig
local mason_lsp_opt = {
	ensure_installed = {},
	automatic_enable = true,
}

-- aerial
local aerial_opt = {
	backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
	lazy_load = true,
	layout = {
		default_direction = "prefer_left",
		placement = "edge",
		resize_to_content = false,
		max_width = 0.2,
		min_width = 0.1,
		width = nil,
		win_opts = {},
	},
	on_attach = function(bufnr)
		-- quit
		vim.keymap.set("n", "<Esc>", "<cmd>AerialClose<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<C-c>", "<cmd>AerialClose<CR>", { buffer = bufnr })
		vim.keymap.set("n", "q", "<cmd>AerialClose<CR>", { buffer = bufnr })
		-- navigate
		vim.keymap.set("n", "<C-p>", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<C-n>", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
	highlight_on_hover = true,
	highlight_on_jump = 300,
	close_automatic_events = {
		switch_buffer = true,
	},
}

local function vimpack_setup_masonlsp()
	vim.pack.add({
		{ src = "https://github.com/neovim/nvim-lspconfig" },
		{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
		{ src = "https://github.com/folke/lazydev.nvim" },
	})
	require("mason-lspconfig").setup(mason_lsp_opt)
end

local function lazy_setup_masonlsp()
end

local function vimpack_setup_aerial()
	vim.pack.add({
		{ src = "https://github.com/stevearc/aerial.nvim" }
	})

	vim.api.nvim_create_autocmd('BufEnter', {
		group = vim.api.nvim_create_augroup('SetupAerial', { clear = true }),
		callback = function()
			require("aerial").setup(aerial_opt)
		end,
	})

	vim.keymap.set("n", "<leader>ss", function()
		local is_split = vim.tbl_count(vim.api.nvim_tabpage_list_wins(0)) > 1
		if is_split then
			vim.cmd("AerialToggle!")
		end
	end, { desc = 'Open aerial'})
end

local function lazy_setup_aerial()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_masonlsp()
	vimpack_setup_aerial()
else
	lazy_setup_masonlsp()
	lazy_setup_aerial()
end

-- specify lsp
require("lsps.lua_ls").setup()

-- diagnostic
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false
})
