local telescope_opt = {
	defaults = {
		layout_config = {
			preview_width = 0.7,
			width = 0.85,
			height = 0.90,
		},
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	},
}

local function config_telescope_keymap(builtin)
	vim.keymap.set('n', '<leader>ff', function()
		builtin.find_files()
	end, { desc = 'Find files' })

	vim.keymap.set('n', '<leader>fg', function()
		builtin.live_grep()
	end, { desc = 'Live grep' })

	vim.keymap.set('n', '<leader>fw', function()
		builtin.string()
	end, { desc = 'Find string' })

	vim.keymap.set('n', '<leader>fb', function()
		builtin.buffers()
	end, { desc = 'Find buffers' })

	vim.keymap.set('n', '<leader>fh', function()
		builtin.help_tags()
	end, { desc = 'Find help tags' })
end

local function vimpack_setup_telescope()
	vim.pack.add({
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		-- dependencies
		{ src = "https://github.com/nvim-lua/plenary.nvim" }
	})

	require('telescope').setup(telescope_opt)
	local Builtin = require('telescope.builtin')
	config_telescope_keymap(Builtin)
end

local function lazy_setup_telescope()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_telescope()
else
	lazy_setup_telescope()
end


