local function lazy_setup()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup({
		spec = {
			{ import = "plugins" },
		},
		install = { colorscheme = { "catppuccin" } },
		checker = { enabled = true }, -- automatically check for plugin updates
	})
end

local function vimpack_setup()
	-- look
	require("plugins.look")
	-- buffer
	require("plugins.buffer")
	-- file
	require("plugins.file")
	-- code
	require("plugins.treesitter")
	require("plugins.cmp")
	require("plugins.mason")
	require("plugins.lsp")
	require("plugins.dap")
	require("plugins.fmt")
	require("plugins.which-key")
	-- md
	require("plugins.markdown")
	-- csv
	require("plugins.csv")
	-- pi
	require("plugins.pi")
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup()
	-- nothing
else
	lazy_setup()
end

