local catppuccin_opt = {
	flavour = 'mocha',
	no_italic = true,
	integrations = {
		alpha = true,
		blink_cmp = { style = "bordered" },
		mason = true,
		telescope = {
			enabled = true,
		}
	},
	transparent_background = true
}

local lualine_opt = {
	options = {
		icons_enable = true,
		theme = {
			normal = {
				a = { bg = "#b4befe", fg = "#1e1e2e", gui = "bold" },
				b = { bg = "#f5c2e7", fg = "#1e1e2e" },
				c = { bg = "#363a4f", fg = "#cdd6f4" },
			},
			insert = {
				a = { bg = "#a6e3a1", fg = "#1e1e2e", gui = "bold" },
			},
			visual = {
				a = { bg = "#89b4fa", fg = "#1e1e2e", gui = "bold" },
			},
		},
		section_separators = { "", "" },
		component_separators = { "", "" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icons_enabled = true,
				icon = "",
			},
		},
		lualine_b = {
			{
				"filename",
				path = 1,
			},
			{
				"filetype",
				colored = true,
				icon_only = true,
				icon = { align = "left" },
			},
		},
		lualine_c = {
			{
				"branch",
				icons_enabled = false,
				icon = "",
			},
			{
				"diff",
			},
		},
		lualine_x = {
			{
				"lsp_status",
				icon = "󰒋",
				symbols = {
					spinner = { "", "", "", "", "", "", "" },
					done = "",
					separator = " ",
				},
				show_name = true,
			},
		},
		lualine_y = { "encoding" },
		lualine_z = { "diagnostics" },
	},
}

local function config_alpha_dashboard(dashboard)
	local height = vim.fn.winheight(0)
	if height > 36 then
		return
	elseif height > 33 and height <=36 then
		dashboard.section.header.val = {
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
	elseif height > 30 and height <= 33 then
		dashboard.section.header.val = {
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
	else
		return
	end

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

local function vimpack_setup_catppuccin()
	vim.pack.add({
		{ src = "https://github.com/catppuccin/nvim" },
	})

	require('catppuccin').setup(catppuccin_opt)
	vim.cmd("colorscheme catppuccin")
end

local function vimpack_setup_icon()
	vim.pack.add({
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	})

	require('nvim-web-devicons').setup()
end

local function vimpack_setup_lualine()
	vim.pack.add({
		{ src = "https://github.com/nvim-lualine/lualine.nvim"},
	})

	require("lualine").setup(lualine_opt)
end

local function vimpack_setup_alpha()
	vim.pack.add({
		{ src = "https://github.com/goolord/alpha-nvim" }
	})

	local Dashboard = require("alpha.themes.dashboard")
	config_alpha_dashboard(Dashboard)

	require('alpha').setup(Dashboard.config) -- use dashboard theme to startup
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_catppuccin()
	vimpack_setup_icon()
	vimpack_setup_lualine()
	-- vimpack_setup_alpha()
else
end
