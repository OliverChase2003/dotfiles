local treesitter_opt = {
	install_dir = vim.fn.stdpath('data') .. '/site'
}

local function vimpack_setup_treesitter()
	vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } })

	local group = vim.api.nvim_create_augroup("SetupTreesitter", { clear = true })

	vim.api.nvim_create_autocmd('BufReadPre', {
		group = group,
		once = true,
		callback = function()
			require('nvim-treesitter').setup(treesitter_opt)
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
end

local function lazy_setup_treesitter()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_treesitter()
else
	lazy_setup_treesitter()
end
