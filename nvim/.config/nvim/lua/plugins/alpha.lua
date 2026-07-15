local Enable = true

if Enable == false then return end

local function config_alpha_dashboard(dashboard)
	dashboard.section.header.val = {
		"                                                     ",
		"                                                     ",
		"                                                     ",
		"                                                     ",
		"                                                     ",
		"                                                     ",
		"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		"                                                     ",
	}

	dashboard.section.buttons.val = {
		-- oil
		dashboard.button('<leader>e', 'Open oil (float)'),
		dashboard.button('<leader>fe', 'Open oil'),
		-- mason
		dashboard.button('<leader>m', 'Open mason'),
		-- terminal
		dashboard.button('<leader>tt', 'Terminal fullscreen'),
		dashboard.button('<leader>tv', 'Terminal split vertical'),
		dashboard.button('<leader>tc', 'Terminal split horizontal'),
		-- update plugins
		dashboard.button('<leader>up', 'Update neovim plugins'),
		-- quit
		dashboard.button('<leader>qq', 'Quit all')
	}
end

local function vimpack_setup_alpha()
	vim.pack.add({
		{ src = "https://github.com/goolord/alpha-nvim" }
	})

	local Dashboard = require("alpha.themes.dashboard")
	config_alpha_dashboard(Dashboard)

	require('alpha').setup(Dashboard.config) -- use dashboard theme to startup
end

local function lazy_setup_alpha()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_alpha()
else
	lazy_setup_alpha()
end
