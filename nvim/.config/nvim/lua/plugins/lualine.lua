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

local function vimpack_setup_lualine()
	vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })

	require("lualine").setup(lualine_opt)
end

local function lazy_setup_lualine()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_lualine()
else
	lazy_setup_lualine()
end
