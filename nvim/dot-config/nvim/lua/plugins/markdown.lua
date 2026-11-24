local render_makrdown_status = true

local render_markdown_opt = {
	file_types = { 'markdown', 'vimwiki', 'norg', 'typst' },
	-- 不在光标行隐藏已渲染内容（图标/边框/竖线等），光标行也保持预览
	-- anti_conceal = { enabled = false },
	-- 渲染时让光标行也参与 conceal（默认 rendered = ''，即光标行显示原始语法）
	win_options = {
		concealcursor = { rendered = 'n' },
	},
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
		preset = 'none',	-- 'round' 'none'
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

local function vimpack_setup_render_markdown()
	vim.pack.add({
		{ src = "https://github.com/3rd/image.nvim" },
		{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
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

	vim.api.nvim_create_autocmd("InsertEnter", {
		pattern = { "markdown", "vimwiki", "norg", "typst" },
		callback = function()
			render_makrdown_status = require('render-markdown.state').get(0).enabled
			vim.cmd("RenderMarkdown disable")
		end,
	})

	vim.api.nvim_create_autocmd("InsertLeave", {
		pattern = { "markdown", "vimwiki", "norg", "typst" },
		callback = function()
			if render_makrdown_status == true then
				vim.cmd("RenderMarkdown enable")
			end
		end,
	})

	vim.keymap.set('n', '<leader>md', function()
		vim.cmd("RenderMarkdown toggle")
	end, { desc = 'Toggle render markdown' })
end

local function lazy_setup_render_markdown()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_render_markdown()
else
	lazy_setup_render_markdown()
end

-- keymaps
