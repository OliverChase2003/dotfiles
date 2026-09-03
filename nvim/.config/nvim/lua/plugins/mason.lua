local mason_opt = {
	ui = {
		border = "single",
		icons = {
			package_installed = " ",
			package_pending = " ",
			package_uninstalled = " ",
		},
	},
}

local function vimpack_setup_mason()
	vim.pack.add({
		{ src = "https://github.com/mason-org/mason.nvim" }
	})

	require("mason").setup(mason_opt)
end

local function lazy_setup_mason()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_mason()
else
	lazy_setup_mason()
end

-- keymaps
vim.keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Open mason" })
