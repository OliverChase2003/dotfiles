local Enable = true

if Enable == false then return end

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
	}
}

local function vimpack_setup_catppuccin()
	vim.pack.add({ { src = "https://github.com/catppuccin/nvim" } })
	require('catppuccin').setup(catppuccin_opt)
end

local function lazy_setup_catppuccin()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_catppuccin()
	vim.cmd("colorscheme catppuccin")
else
	lazy_setup_catppuccin()
end

