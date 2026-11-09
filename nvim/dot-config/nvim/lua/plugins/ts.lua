local treesitter_opt = {
	install_dir = vim.fn.stdpath('data') .. '/site'
}

local ts_context_opt = {
	enable = true,
	multiwindow = false,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = 'outer',
	mode = 'cursor',
	separator = nil,
	zindex = 20,
	on_attach = nil,
}

local function vimpack_setup_treesitter()
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context"}
	})

	local group = vim.api.nvim_create_augroup("SetupTreesitter", { clear = true })

	vim.api.nvim_create_autocmd('BufReadPre', {
		group = group,
		once = true,
		callback = function()
			require('nvim-treesitter').setup(treesitter_opt)
			require('treesitter-context').setup(ts_context_opt)
		end,
	})

	vim.api.nvim_create_autocmd('FileType', {
		group = group,
		callback = function()
			local ft = vim.bo.filetype
			if ft == '' then return end
			local ok, ts = pcall(require, 'nvim-treesitter')
			if ok and vim.tbl_contains(ts.get_available(), ft) then
				ts.install({ ft })
			end
		end,
	})

	vim.keymap.set("n", "gc", function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end, { silent = true })
end

local function lazy_setup_treesitter()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_treesitter()
else
	lazy_setup_treesitter()
end
