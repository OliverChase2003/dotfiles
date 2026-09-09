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

local imagenvim_opt = {
	backend = "kitty", -- or "ueberzug" or "sixel"
	processor = "magick_cli", -- or "magick_rock"
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = true,
			only_render_image_at_cursor_mode = "inline", -- "popup" or "inline"
			floating_windows = false, -- if true, images will be rendered in floating markdown windows
			filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
		},
		neorg = {
			enabled = true,
			filetypes = { "norg" },
		},
		typst = {
			enabled = true,
			filetypes = { "typst" },
		},
		html = {
			enabled = false,
		},
		css = {
			enabled = false,
		},
	},
	max_width_window_percentage = 80,
	max_height_window_percentage = 50,
	scale_factor = 1.0,
	window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
	editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
	tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
}

local function vimpack_setup_render_markeown()
	vim.pack.add({
		{ src = "https://github.com/3rd/image.nvim" },
		{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("SetupRenderMarkdown", { clear = true }),
		pattern = { "markdown", "vimwiki", "norg", "typst" },
		once = true,
		callback = function()
			require("image").setup(imagenvim_opt)
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
vim.keymap.set('n', '<leader>md', '<CMD>RenderMarkdown toggle<CR>', { desc = 'Toggle render markdown' })

