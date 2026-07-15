local cleanup_group = vim.api.nvim_create_augroup('CleanupEmptyNoNameBuffer', { clear = true })

local function is_empty_no_name_buffer(bufnr)
	if bufnr == nil or not vim.api.nvim_buf_is_valid(bufnr) then
		return false
	end

	if vim.api.nvim_buf_get_name(bufnr) ~= '' then
		return false
	end

	if vim.bo[bufnr].buftype ~= '' or vim.bo[bufnr].modified then
		return false
	end

	if #vim.fn.win_findbuf(bufnr) > 0 then
		return false
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 2, false)
	return #lines == 1 and lines[1] == ''
end

vim.api.nvim_create_autocmd('BufEnter', {
	group = cleanup_group,
	callback = function(args)
		local current = args.buf
		if vim.api.nvim_buf_get_name(current) == '' and vim.bo[current].buftype == '' then
			return
		end

		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if bufnr ~= current and is_empty_no_name_buffer(bufnr) then
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end
		end
	end,
})
