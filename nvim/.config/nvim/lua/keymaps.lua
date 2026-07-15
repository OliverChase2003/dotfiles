-- move between windows
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('i', '<C-h>', '<Esc><C-w>h')
vim.keymap.set('i', '<C-j>', '<Esc><C-w>j')
vim.keymap.set('i', '<C-k>', '<Esc><C-w>k')
vim.keymap.set('i', '<C-l>', '<Esc><C-w>l')
-- resize window
vim.keymap.set('n', '<C-Down>', ':resize -1<CR>', { desc = 'Resize window shorter' })
vim.keymap.set('n', '<C-Up>', ':resize +1<CR>', { desc = 'Resize window taller' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -1<CR>', { desc = 'Resize window narrower' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +1<CR>', { desc = 'Resize window wider' })
-- edit
vim.keymap.set('n', '<leader>oo', 'i<CR><ESC>', { desc = 'Split line'})
vim.keymap.set('n', '<leader>oO', 'i<S-CR><ESC>', { desc = 'Split line'})
-- terminal
vim.keymap.set('n', '<leader>tt', ':terminal<CR>a', { desc = 'Open terminal' })
vim.keymap.set('n', '<leader>tv',
	':belowright vsplit | terminal<CR>:vertical resize ' .. math.floor(vim.o.columns * 0.5) .. '<CR>a',
	{ desc = 'Open terminal vertical' }
)
vim.keymap.set('n', '<leader>tc',
	':belowright split | terminal<CR>:resize ' .. math.floor(vim.o.lines * 0.3) .. '<CR>a',
	{ desc = 'Open terminal horizontal' }
)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Quit terminal mode' })
-- quit
vim.keymap.set('n', '<leader>qq', ':qa!<CR>', { desc = 'Quit all' })
-- restart
vim.keymap.set('n', '<leader>rr', ':restart<CR>', { desc = 'Restart neovim' })
-- upgrade plugins
vim.keymap.set('n', '<leader>up', ':lua vim.pack.update()<CR>', { desc = 'Update plugins' })
