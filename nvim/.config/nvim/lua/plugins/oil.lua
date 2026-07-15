local oil_opt = {
	default_file_explorer = true,
	columns = {
		'icon',
		{ 'size', highlight = 'Special' },
		{ 'permissions', highlight = 'Comment' },
	},
	win_options = {
		wrap = false,
		cursorcolumn = true,
		signcolumn = "no",
		foldcolumn = "0",
		spell = false,
		list = false,
		conceallevel = 3,
		concealcursor = "nvic",
	},
	float = {
		padding = 2,
		max_width = 0.6,
		max_height = 0.6,
		border = 'single', -- single, double, shadow, rounded
		win_options = {
			winblend = 0
		}
	},
	confirmation = {
		max_width = 0.8,
		min_width = 0.4,
		max_height = 0.2,
		min_height = 0.2,
		border = 'single',
		win_options = {
			winblend = 0
		}
	},
	progress = {
		max_width = 0.6,
		min_width = 0.3,
		max_height = 0.2,
		min_height = 0.1,
		border = 'single',
		win_options = {
			winblend = 0
		}
	},
	view_options = {
		show_hidden = true,
		natural_order = "fast",
		case_insensitive = false,
		sort = {
			{ 'type', 'asc' },
			{ 'name', 'asc' }
		},
		is_hidden_file = function(name, bufnr)
			local m = nil
			m = name:match('^%.')
			-- m = name:match('%.lock$')
			return m ~= nil
		end,
		is_always_hidden = function(name, bufnr)
			local m = (name == '..')
			return m
		end,
		highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
			if is_hidden and not is_link_target then
				return 'Comment'
			end
			if is_link_target then
				return 'Special'
			end
			if is_link_orphan then
				return 'WarningMsg'
			end
			return nil
		end
	},
	constrain_cursor = "editable",
	watch_for_changes = true,
	use_default_keymaps = false,
	keymaps = {
		-- open file / back to parent
		["<CR>"] = { 'actions.select', mode = 'n' },
		["  "] = { 'actions.select', mode = 'n' },
		['L'] = { 'actions.select', mode = 'n' },
		['H'] = { 'actions.parent', mode = 'n' },
		-- open vertical / horizontal / new tab
		['v'] = { 'actions.select', opts = { vertical = true } },
		['c'] = { 'actions.select', opts = { horizontal = true } },
		['t'] = { 'actions.select', opts = { tab = true } },
		-- close
		['<leader>e'] = { 'actions.close', mode = 'n' },
		['<leader>fe'] = { 'actions.close', mode = 'n' },
		['C-c'] = { 'actions.close', mode = 'n' },
		['<Esc>'] = { 'actions.close', mode = 'n' },
		['q'] = { 'actions.close', mode = 'n' },
		-- toggle hidden
		['.'] = { 'actions.toggle_hidden', mode = 'n' }
	}
}

local oilgit_opt = {
	highlights = {
		OilGitAdded = { fg = "#a6e3a1" },     -- green
		OilGitModified = { fg = "#f9e2af" },  -- yellow
		OilGitRenamed = { fg = "#cba6f7" },   -- purple
		OilGitUntracked = { fg = "#89b4fa" }, -- blue
		OilGitIgnored = { fg = "#6c7086" },   -- gray
	}
}

local function vimpack_setup_oil()
	vim.pack.add({
		{ src = "https://github.com/stevearc/oil.nvim" },
		{ src = "https://github.com/benomahony/oil-git.nvim" },
	})
	require('oil').setup(oil_opt)
	require("oil-git").setup(oilgit_opt)
end

local function lazy_setup_oil()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_oil()
else
	lazy_setup_oil()
end

-- keymaps for oil
vim.keymap.set("n", "<leader>e",
	function()
		require("oil").open_float()
	end,
	{ desc = "Oil float" })

vim.keymap.set('n', '<leader>fe',
	function()
		require("oil").open()
	end
	, { desc = 'Oil' })
