-- navigate
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('i', '<C-h>', '<Esc><C-w>h')
vim.keymap.set('i', '<C-j>', '<Esc><C-w>j')
vim.keymap.set('i', '<C-k>', '<Esc><C-w>k')
vim.keymap.set('i', '<C-l>', '<Esc><C-w>l')

-- resize
vim.keymap.set('n', '<C-Down>', '<CMD>resize -1<CR>', { desc = 'Resize window shorter' })
vim.keymap.set('n', '<C-Up>', '<CMD>resize +1<CR>', { desc = 'Resize window taller' })
vim.keymap.set('n', '<C-Left>', '<CMD>vertical resize -1<CR>', { desc = 'Resize window narrower' })
vim.keymap.set('n', '<C-Right>', '<CMD>vertical resize +1<CR>', { desc = 'Resize window wider' })

-- buffer
vim.keymap.set('n', '<leader>bb', '<CMD>e!<CR>', { desc = 'Reload buffer'})
vim.keymap.set('n', '<leader>bd', function()
	-- ban this keymap while nvim-dap-ui opened
	if DapuiStatus == true then return end
	vim.cmd('bdelete')
end, { desc = 'Delete buffer' })

vim.keymap.set('n', '<leader>bx', function()
	if DapuiStatus == true then return end
	vim.cmd('bdelete!')
end, { desc = 'Force delete buffer' })

vim.keymap.set('n', '<C-d>', function()
	if DapuiStatus == true then return end

	local no_split = not (#vim.api.nvim_list_wins() > 1)

	local no_buffer = #vim.fn.getbufinfo({ buflisted = 1 }) == 1

	local is_empty = vim.api.nvim_buf_line_count(0) == 1
		and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == ""

	local is_no_name = vim.api.nvim_buf_get_name(0) == ''

	if is_empty and is_no_name and no_buffer and no_split then
		vim.cmd('qa')
		return
	end

	vim.cmd('bdelete!')
end, { desc = 'Force delete buffer (quit if sole [No Name])'})

-- edit
vim.keymap.set('n', '<leader>oo', 'i<CR><ESC>', { desc = 'Split line'})
vim.keymap.set('n', '<leader>oO', 'i<S-CR><ESC>', { desc = 'Split line'})

-- lsp
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })

vim.keymap.set('n', 'K', function()
	vim.lsp.buf.hover({
		border = 'single',
	})
end, { desc = 'Hover docs' }
)

vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(
		not vim.lsp.inlay_hint.is_enabled()
	)
end, { desc = 'Toggle inlay hint' }
)

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename variable'})

-- terminal
vim.keymap.set('n', '<leader>tt', '<CMD>terminal<CR>a', { desc = 'Open terminal' })

vim.keymap.set('n', '<leader>tv',
	'<CMD>belowright vsplit | terminal<CR><CMD>vertical resize ' .. math.floor(vim.o.columns * 0.5) .. '<CR>a',
	{ desc = 'Open terminal vertical' }
)

vim.keymap.set('n', '<leader>tc',
	'<CMD>belowright split | terminal<CR><CMD>resize ' .. math.floor(vim.o.lines * 0.3) .. '<CR>a',
	{ desc = 'Open terminal horizontal' }
)

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Quit terminal mode' })
vim.keymap.set('t', '<C-e>', '<C-\\><C-n>', { desc = 'Quit terminal mode' })

-- write
vim.keymap.set('n', '<leader>ww', '<CMD>w<CR>', { desc = 'Write' })

-- quit
vim.keymap.set('n', '<leader>qq', '<CMD>qa!<CR>', { desc = 'Quit all' })

-- restart
vim.keymap.set('n', '<leader>rr', '<CMD>restart<CR>', { desc = 'Restart neovim' })

-- upgrade plugins
if vim.fn.has("nvim-0.12") == 1 then
	vim.keymap.set('n', '<leader>up', '<CMD>lua vim.pack.update()<CR>', { desc = 'Update plugins' })
end
