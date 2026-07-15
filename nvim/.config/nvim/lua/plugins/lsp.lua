-- mason lspconfig
local mason_lsp_opt = {
	ensure_installed = {},
	automatic_enable = true,
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

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_masonlsp()
else
	lazy_setup_masonlsp()
end

-- specify lsp
require("lsp.lua_ls").setup()

-- diagnostic
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'gO', function()
	vim.lsp.buf.document_symbol({
		loclist = true,
	})
end, { desc = 'Go to document symbol' })
vim.keymap.set('n', 'K',
	function()
		vim.lsp.buf.hover({
			border = 'single',
		})
	end,
	{ desc = 'Hover docs' })

vim.keymap.set("n", "<leader>ih",
	function()
		vim.lsp.inlay_hint.enable(
			not vim.lsp.inlay_hint.is_enabled()
		)
	end,
	{ desc = 'Toggle inlay hint' }
)
