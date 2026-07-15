local csvview_opt = {
	parser = { comments = { "#", "//" } },
	keymaps = {
		textobject_field_inner = { "if", mode = { "o", "x" } },
		textobject_field_outer = { "af", mode = { "o", "x" } },
		jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
		jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
		jump_next_row = { "<Enter>", mode = { "n", "v" } },
		jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
	},
}

local function vimpack_setup_csv_view()
	vim.pack.add({ { src = "https://github.com/hat0uma/csvview.nvim" } })

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("SetupCsvView", { clear = true
		}),
		pattern = "csv",
		once = true,
		callback = function()
			require('csvview').setup(csvview_opt)
		end,
	})
end

local function lazy_setup_csv_view()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_csv_view()
else
	lazy_setup_csv_view()
end

vim.keymap.set('n', '<leader>csv',
	':CsvViewToggle delimiter=, display_mode=border header_lnum=1<CR>',
	{ desc = 'Csv view' }
)
