local Enable = true

if Enable == false then return end

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
	vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } })

	vim.api.nvim_create_autocmd("BufAdd", {
		callback = function()
			require('bufferline').setup(bufferline_opt)
		end,
		once = true,
	})
end

local function lazy_setup_bufferline()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_bufferline()
else
	lazy_setup_bufferline()
end

-- keymaps
vim.keymap.set('n', 'H', '<CMD>BufferLineCyclePrev<CR>', { desc = 'Prev buffer' })
vim.keymap.set('n', 'L', '<CMD>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<', '<CMD>BufferLineMovePrev<CR>', { desc = 'Move left' })
vim.keymap.set('n', '>', '<CMD>BufferLineMoveNext<CR>', { desc = 'Move right' })

vim.keymap.set('n', '<leader>bd', function()
	-- ban this keymap while nvim-dap-ui opened
	if DapuiStatus == true then return end
	-- OpencodeStatus = vim.inspect(require('opencode.ui.ui').is_opencode_focused())
	-- if OpencodeStatus == true then return end
	vim.cmd('bdelete')
end, { desc = 'Delete buffer' })

vim.keymap.set('n', '<leader>bx', function()
	if DapuiStatus == true then return end
	-- OpencodeStatus = vim.inspect(require('opencode.ui.ui').is_opencode_focused())
	-- if OpencodeStatus == true then return end
	vim.cmd('bdelete!')
end, { desc = 'Force delete buffer' })
