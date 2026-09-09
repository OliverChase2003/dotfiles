local conform_opt = {
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
	},
}

local function vimpack_setup_conform()
	vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })

	vim.api.nvim_create_autocmd("BufRead", {
		group = vim.api.nvim_create_augroup("SetupConform", { clear = true }),
		once = true,
		callback = function()
			require("conform").setup(conform_opt)
		end
	})
end

local function lazy_setup_conform()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_conform()
else
	lazy_setup_conform()
end

vim.keymap.set("n", "<leader>fm",
	function()
		require("conform").format()
	end,
	{ desc = "Format code" }
)
