local render_markdown_opt = {
		file_types = { 'markdown', 'vimwiki', 'norg', 'typst' },
		-- anti_conceal = { enabled = false },
		completions = {
			lsp = { enabled = true },
			blink = { enabled = true }
		},
		sign = { enabled = false },
		-- headings
		heading = {
			enabled = true,
			render_modes = true,
			atx = true,
			setext = true,
			icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
			position = 'inline',
			-- border
			border = true,
			width = 'block',
		},
		-- paragraph use default
		-- code block
		code = {
			render_modes = false,
			-- conceal_delimiters = true,
			width = 'block',
			-- language info
			language = true,
			language_icon = true,
			language_name = true,
			position = 'left',
			-- border
			border = 'thin',
			min_width = 80,
			inline = true,
			-- highlight
			highlight_inline = 'RenderMarkdownCodeInfo'
		},
		-- dash use default
		-- list-bullet use default
		-- checkbox use default
		checkbox = {
			checked = { scope_highlight = '@markup.strikethrough' }
		},
		-- table
		pipe_table = {
			preset = 'round'
		},
		-- quotes
		quote = {
			repeat_linebreak = true,
		},
		image = {
			enabled = true
		}
	}

local function vimpack_setup_render_markeown()
	vim.pack.add({ { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" } })

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("SetupRenderMarkdown", { clear = true }),
		pattern = { "markdown", "vimwiki", "norg", "typst" },
		once = true,
		callback = function()
			require('render-markdown').setup(render_markdown_opt)
		end,
	})
end

local function lazy_setup_render_markeown()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_render_markeown()
else
	lazy_setup_render_markeown()
end

-- keymaps
vim.keymap.set('n', '<leader>Md', ':RenderMarkdown toggle<CR>', { desc = 'Toggle render markdown' })

