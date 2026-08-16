local Enable = true

if Enable == false then return end

if not vim.fn.has("nvim-0.10") == 1 then
	return
end

local blink_opt = {
	completion = {
		documentation = { auto_show = false },
		trigger = {
			show_on_keyword = true,
			show_on_trigger_character = true,
			show_on_blocked_trigger_characters = {
				' ', '\n', '\t'
			},
			show_on_insert_on_trigger_character = true,
			show_on_x_blocked_trigger_characters = {
				"'", '"', '(', '{', '['
			}
		},
		list = {
			selection = { preselect = true, auto_insert = false }
		},
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind" }
				}
			}
		}
	},
	keymap = {
		['<C-p>'] = { 'select_prev', 'fallback' },
		['<C-n>'] = { 'select_next', 'fallback' },
		['<C-s>'] = { 'show', 'fallback' },
		['<C-e>'] = { 'hide', 'fallback' },
		['<Tab>'] = { 'accept', 'fallback' },
		['<C-d>'] = false, --{ 'show_documentation' }
		['<C-D>'] = false, --{ 'hide_documentation' }
		['<C-space>'] = false -- tmux leader
	},
	cmdline = {
		keymap = {
			['<C-p>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'fallback' },
			['<C-s>'] = { 'show', 'fallback' },
			['<C-e>'] = { 'hide', 'fallback' },
			['<Tab>'] = { 'accept', 'fallback' },
			['<C-d>'] = false,
			['<C-D>'] = false,
			['<C-space>'] = false,
		},
		completion = { menu = { auto_show = true } },
	},
	sources = {
		default = { 'lsp', 'path', 'buffer' },
		-- per_filetype = {
		-- 	sql = { 'dadbod', 'buffer' }
		-- },
		-- providers = {
		-- 	dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
		-- }
	},
	signature = { enabled = true },
	-- fuzzy = { implementation = "lua" },
	fuzzy = { implementation = "prefer_rust_with_warning" },
}

local function vimpack_setup_blink()
	vim.pack.add({
		{ src = 'https://github.com/saghen/blink.cmp', version = 'v1' }
	})

	vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
		group = vim.api.nvim_create_augroup("SetupCompletion", { clear = true }),
		once = true,
		callback = function()
			require('blink.cmp').setup(blink_opt)
		end
	})
end

local function lazy_setup_blink()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_blink()
else
	lazy_setup_blink()
end
