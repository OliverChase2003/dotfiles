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
		window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
		editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
		tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
		hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
	}

local function vimpack_setup_imagenvim()
	vim.pack.add({ { src = "https://github.com/3rd/image.nvim" } })

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("SetupMarkdownImage", { clear = true }),
		pattern = { "markdown", "vimwiki", "norg", "typst" },
		once = true,
		callback = function()
			require("image").setup(imagenvim_opt)
		end,
	})
end

local function lazy_setup_imagenvim()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_imagenvim()
else
	lazy_setup_imagenvim()
end
