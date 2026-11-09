local mocha = require("catppuccin.palettes").get_palette "mocha"

local bufferline_opt = {
	highlights = require("catppuccin.special.bufferline").get_theme {
		styles = { 'bold' },
		custom = {
			all = {
				fill = { bg = '#313244'},
				background = { fg = mocha.text }
			}
		}
	}
}

local function vimpack_setup_bufferline()
	vim.pack.add({
		{ src = "https://github.com/akinsho/bufferline.nvim" }
	})

	vim.api.nvim_create_autocmd("BufAdd", {
		callback = function()
			require('bufferline').setup(bufferline_opt)
		end,
		once = true,
	})

	vim.keymap.set('n', 'H', '<CMD>BufferLineCyclePrev<CR>', { desc = 'Prev buffer' })
	vim.keymap.set('n', 'L', '<CMD>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
	vim.keymap.set('n', '<', '<CMD>BufferLineMovePrev<CR>', { desc = 'Move left' })
	vim.keymap.set('n', '>', '<CMD>BufferLineMoveNext<CR>', { desc = 'Move right' })
end

local function lazy_setup_bufferline()
	require('bufferline').setup(bufferline_opt)
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_bufferline()
else
	lazy_setup_bufferline()
end
