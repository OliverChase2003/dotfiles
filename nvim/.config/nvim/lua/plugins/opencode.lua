local opencode_opt = {
	preferred_picker = nil, -- 'telescope', 'fzf', 'mini.pick', 'snacks', 'select', if nil, it will use the best available picker. Note mini.pick does not support multiple selections
	preferred_completion = nil, -- 'blink', 'nvim-cmp','vim_complete' if nil, it will use the best available completion
	default_global_keymaps = true, -- If false, disables all default global keymaps
	default_mode = 'plan', -- 'build' or 'plan' or any custom configured. @see [OpenCode Agents](https://opencode.ai/docs/modes/)
	default_system_prompt = nil, -- Custom system prompt to use for all sessions. If nil, uses the default built-in system prompt
	keymap_prefix = '<leader>o', -- Default keymap prefix for global keymaps change to your preferred prefix and it will be applied to all keymaps starting with <leader>o
	opencode_executable = 'opencode', -- Name of your opencode binary

	-- Server configuration for custom/external opencode servers
	server = {
		url = nil,             -- URL/hostname (e.g., 'http://192.168.1.100', 'localhost', 'https://myserver.com')
		port = nil,            -- Port number (e.g., 8080), 'auto' for random port
		timeout = 5,           -- Health check timeout in seconds when connecting
		spawn_command = nil,   -- Optional function to start the server: function(port, url) ... end
		auto_kill = true,      -- Kill spawned servers when last nvim instance exits (default: true) Only applies to servers spawned by the plugin with spawn_command/kill_command
		path_map = nil,        -- Map host paths to server paths: string ('/app') or function(path) -> string
	},
	keymap = {
		editor = {
			['<leader>og'] = { 'toggle', desc = 'Toggle opencode' }, -- Open opencode. Close if opened
			-- ['<leader>on'] = { 'open'}
			-- ['<leader>oi'] = { 'open_input' }, -- Opens and focuses on input window on insert mode
			['<leader>oi'] = false,
			-- ['<leader>oI'] = { 'open_input_new_session' }, -- Opens and focuses on input window on insert mode. Creates a new session
			['<leader>oI'] = false,
			-- ['<leader>oo'] = { 'open_output' }, -- Opens and focuses on output window
			['<leader>oo'] = false,
			-- ['<leader>ot'] = { 'toggle_focus' }, -- Toggle focus between opencode and last window
			['<leader>ot'] = false,
			-- ['<leader>oT'] = { 'timeline' }, -- Display timeline picker to navigate/undo/redo/fork messages
			['<leader>oT'] = false,
			-- ['<leader>oq'] = { 'close' }, -- Close UI windows
			['<leader>oq'] = false,
			['<leader>os'] = { 'select_session', desc = 'Select session'}, --  Select and load a opencode session
			-- ['<leader>oR'] = { 'rename_session' }, -- Rename current session
			['<leader>oR'] = false,
			['<leader>op'] = { 'configure_provider', desc = 'Configure provider'}, --  Quick provider and model switch from predefined list
			--['<leader>oV'] = { 'configure_variant' }, --  Switch model variant for the current model
			['<leader>oV'] = false,
			['<leader>ov'] = { 'configure_variant', desc = 'Switch variant' },
			-- ['<leader>oy'] = { 'add_visual_selection', mode = {'v'} },
			['<leader>oy'] = { 'add_visual_selection_inline', mode = {'v'}, desc = 'Add selection inline' }, --  Insert visual selection as inline code block in the input buffer
			-- ['<leader>oY'] = { 'add_visual_selection_inline', mode = {'v'} }, -- Insert visual selection as inline code block in the input buffer
			['<leader>oY'] = false,
			-- ['<leader>oz'] = { 'toggle_zoom' }, -- Zoom in/out on the Opencode windows
			['<leader>oz'] = false,
			-- ['<leader>ov'] = { 'paste_image'}, -- Paste image from clipboard into current session
			['<leader>om'] = { 'paste_image', desc = 'Paste image' },
			['<leader>od'] = { 'diff_open', desc = 'Open diff' }, -- Opens a diff tab of a modified file since the last opencode prompt
			['<leader>o]'] = { 'diff_next', desc = 'Next diff' }, -- Navigate to next file diff
			['<leader>o['] = { 'diff_prev', desc = 'Prev diff' }, -- Navigate to previous file diff
			['<leader>oc'] = { 'diff_close', desc = 'Close diff' }, -- Close diff view tab and return to normal editing
			['<leader>ora'] = { 'diff_revert_all_last_prompt', desc = 'Revert all' }, -- Revert all file changes since the last opencode prompt
			['<leader>ort'] = { 'diff_revert_this_last_prompt', desc = 'Revert this' }, -- Revert current file changes since the last opencode prompt
			-- ['<leader>orA'] = { 'diff_revert_all' }, -- Revert all file changes since the last opencode session
			['<leader>orA'] = false,
			-- ['<leader>orT'] = { 'diff_revert_this' }, -- Revert current file changes since the last opencode session
			['<leader>orT'] = false,
			['<leader>orr'] = { 'diff_restore_snapshot_file', desc = 'Restore file' }, -- Restore a file to a restore point
			['<leader>orR'] = { 'diff_restore_snapshot_all', desc = 'Restore all' }, -- Restore all files to a restore point
			-- ['<leader>ox'] = { 'swap_position' }, -- Swap Opencode pane left/right
			['<leader>ox'] = false,
			['<leader>ott'] = { 'toggle_tool_output', desc = 'Toggle tool output' }, -- Toggle tools output (diffs, cmd output, etc.)
			['<leader>otr'] = { 'toggle_reasoning_output', desc = 'Toggle reasoning' }, -- Toggle reasoning output (thinking steps)
			-- ['<leader>o/'] = { 'quick_chat', mode = { 'n', 'x' } }, -- Open quick chat input with selection context in visual mode or current line context in normal mode
			['<leader>o/'] = false,
		},
		input_window = {
			-- ['<S-cr>'] = { 'submit_input_prompt', mode = { 'n', 'i' } }, -- Submit prompt (normal mode and insert mode)
			['<S-cr>'] = false,
			['<esc>'] = { 'close', defer_to_completion = true, desc = 'Close' }, -- Close UI windows
			['<C-c>'] = { 'cancel', defer_to_completion = true, desc = 'Cancel' }, -- Cancel opencode request while it is running
			['~'] = { 'mention_file', mode = 'i', desc = 'Mention file' }, -- Pick a file and add to context. See File Mentions section
			['@'] = { 'mention', mode = 'i', desc = 'Mention' }, -- Insert mention (file/agent)
			['/'] = { 'slash_commands', mode = 'i', desc = 'Slash commands' }, -- Pick a command to run in the input window
			['#'] = { 'context_items', mode = 'i', desc = 'Context items' }, -- Manage context items (current file, selection, diagnostics, mentioned files)
			['<M-v>'] = { 'paste_image', mode = 'i', desc = 'Paste image' }, -- Paste image from clipboard as attachment
			-- ['<tab>'] = { 'toggle_pane', mode = { 'n' }, defer_to_completion = true }, -- Toggle between input and output panes
			['<tab>'] = { 'switch_mode', mode = 'n', desc = 'Switch mode'},
			['<up>'] = { 'prev_prompt_history', mode = { 'n', 'i' }, defer_to_completion = true, desc = 'Prev history' }, -- Navigate to previous prompt in history
			['<down>'] = { 'next_prompt_history', mode = { 'n', 'i' }, defer_to_completion = true, desc = 'Next history' }, -- Navigate to next prompt in history
			-- ['<M-m>'] = { 'switch_mode' }, -- Switch between modes (build/plan)
			['<M-m>'] = false,
			-- ['<M-r>'] = { 'cycle_variant', mode = { 'n', 'i' } }, -- Cycle through available model variants
			['<M-r>'] = false,
			-- self config
			['q'] = { 'close', mode = { 'n' }, desc = 'Close' }, -- Close UI windows
		},
		output_window = {
			['<esc>'] = { 'close', desc = 'Close' }, -- Close UI windows
			['<C-c>'] = { 'cancel', desc = 'Cancel' }, -- Cancel opencode request while it is running
			[']]'] = { 'next_message', desc = 'Next message' }, -- Navigate to next message in the conversation
			['[['] = { 'prev_message', desc = 'Prev message' }, -- Navigate to previous message in the conversation
			-- ['<tab>'] = { 'toggle_pane', mode = { 'n' } }, -- Toggle between input and output panes
			['<tab>'] = { 'switch_mode', mode = 'n', desc = 'Switch between build/plan'},
			['i'] = { 'focus_input', 'n', desc = 'Focus input' }, -- Focus on input window and enter insert mode at the end of the input from the output window
			-- ['<M-r>'] = { 'cycle_variant', mode = { 'n' } }, -- Cycle through available model variants
			['<M-r>'] = false,
			-- ['<leader>oS'] = { 'select_child_session' }, -- Select and load a child session
			['<leader>oS'] = false,
			-- ['<leader>oD'] = { 'debug_message' }, -- Open raw message in new buffer for debugging
			['<leader>oD'] = false,
			-- ['<leader>oO'] = { 'debug_output' }, -- Open raw output in new buffer for debugging
			['<leader>oO'] = false,
			-- ['<leader>ods'] = { 'debug_session' }, -- Open raw session in new buffer for debugging
			['<leader>ods'] = false,
			-- self config
			['q'] = { 'close', desc = 'Close' }, -- Close UI windows
		},
		session_picker = {
			rename_session = { '<C-r>' }, -- Rename selected session in the session picker
			delete_session = { '<C-d>' }, -- Delete selected session in the session picker
			new_session = { '<C-n>' }, -- Create and switch to a new session in the session picker
		},
		timeline_picker = {
			undo = { '<C-u>', mode = { 'i', 'n' } }, -- Undo to selected message in timeline picker
			fork = { '<C-f>', mode = { 'i', 'n' } }, -- Fork from selected message in timeline picker
		},
		history_picker = {
			delete_entry = { '<C-d>', mode = { 'i', 'n' } }, -- Delete selected entry in the history picker
			clear_all = { '<C-X>', mode = { 'i', 'n' } }, -- Clear all entries in the history picker
		},
		model_picker = {
			toggle_favorite = { '<C-f>', mode = { 'i', 'n' } },
		},
		mcp_picker = {
			toggle_connection = { '<C-t>', mode = { 'i', 'n' } }, -- Toggle MCP server connection in the MCP picker
		},
	},
	ui = {
		enable_treesitter_markdown = true, -- Use Treesitter for markdown rendering in the output window (default: true).
		position = 'current', -- 'right' (default), 'left' or 'current'. Position of the UI split. 'current' uses the current window for the output.
		input_position = 'bottom', -- 'bottom' (default) or 'top'. Position of the input window
		window_width = 0.5, -- Width as percentage of editor width
		zoom_width = 0.9, -- Zoom width as percentage of editor width
		display_model = true, -- Display model name on top winbar
		display_context_size = true, -- Display context size in the footer
		display_cost = true, -- Display cost in the footer
		window_highlight = 'Normal:OpencodeBackground,FloatBorder:OpencodeBorder', -- Highlight group for the opencode window
		persist_state = true, -- Keep buffers when toggling/closing UI so window state restores quickly
		icons = {
			preset = 'nerdfonts', -- 'nerdfonts' | 'text'. Choose UI icon style (default: 'nerdfonts')
			overrides = {}, -- Optional per-key overrides, see section below
		},
		questions = {
			use_vim_ui_select = false, -- If true, render questions/prompts with vim.ui.select instead of showing them inline in the output buffer.
		},
		output = {
			filetype = 'markdown', -- Filetype assigned to the output buffer (default: 'opencode_output')
			compact_assistant_headers = false, -- 'full' (default), 'minimal' (compact if same mode), or 'hidden' (no headers for assistant)
			tools = {
				show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
				show_reasoning_output = false, -- Show reasoning/thinking steps output (default: true)
			},
			rendering = {
				markdown_debounce_ms = 250, -- Debounce time for markdown rendering on new data (default: 250ms)
				on_data_rendered = nil, -- Called when new data is rendered; set to false to disable default RenderMarkdown/Markview behavior
			},
			max_messages = nil, -- Max number of messages to keep in the output buffer; older messages will be removed as new ones arrive (default: nil, which means no limit)
		},
		input = {
			min_height = 0.10, -- min height of prompt input as percentage of window height
			max_height = 0.25, -- max height of prompt input as percentage of window height
			text = {
				wrap = false, -- Wraps text inside input window
			},
			-- Auto-hide input window when prompt is submitted or focus switches to output window
			auto_hide = false,
		},
		picker = {
			snacks_layout = nil -- `layout` opts to pass to Snacks.picker.pick({ layout = ... })
		},
		completion = {
			file_sources = {
				enabled = true,
				preferred_cli_tool = 'server', -- 'fd','fdfind','rg','git','server' if nil, it will use the best available tool, 'server' uses opencode cli to get file list (works cross platform) and supports folders
				ignore_patterns = {
					'^%.git/',
					'^%.svn/',
					'^%.hg/',
					'node_modules/',
					'%.pyc$',
					'%.o$',
					'%.obj$',
					'%.exe$',
					'%.dll$',
					'%.so$',
					'%.dylib$',
					'%.class$',
					'%.jar$',
					'%.war$',
					'%.ear$',
					'target/',
					'build/',
					'dist/',
					'out/',
					'deps/',
					'%.tmp$',
					'%.temp$',
					'%.log$',
					'%.cache$',
				},
				max_files = 10,
				max_display_length = 50, -- Maximum length for file path display in completion, truncates from left with "..."
			},
		},
	},
	context = {
		enabled = true, -- Enable automatic context capturing
		cursor_data = {
			enabled = false, -- Include cursor position and line content in the context
			context_lines = 5, -- Number of lines before and after cursor to include in context
		},
		diagnostics = {
			info = false, -- Include diagnostics info in the context (default to false
			warning = true, -- Include diagnostics warnings in the context
			error = true, -- Include diagnostics errors in the context
			only_closest = false, -- If true, only diagnostics for cursor/selection
		},
		current_file = {
			enabled = true, -- Include current file path and content in the context
			show_full_path = true,
		},
		files = {
			enabled = true,
			show_full_path = true,
		},
		selection = {
			enabled = true, -- Include selected text in the context
		},
		buffer = {
			enabled = false, -- Disable entire buffer context by default, only used in quick chat
		},
		git_diff = {
			enabled = false,
		},
	},
	logging = {
		enabled = false,
		level = 'warn', -- debug, info, warn, error
		outfile = nil,
	},
	debug = {
		enabled = false, -- Enable debug messages in the output window
		capture_streamed_events = false,
		show_ids = true,
		quick_chat = {
			keep_session = false, -- Keep quick_chat sessions for inspection, this can pollute your sessions list
			set_active_session = false,
		},
	},
	prompt_guard = nil, -- Optional function that returns boolean to control when prompts can be sent (see Prompt Guard section)

	-- User Hooks for custom behavior at certain events
	hooks = {
		on_file_edited = nil, -- Called after a file is edited by opencode.
		on_session_loaded = nil, -- Called after a session is loaded.
		on_done_thinking = nil, -- Called when opencode finishes thinking (all jobs complete).
		on_permission_requested = nil, -- Called when a permission request is issued.
	},
	quick_chat = {
		default_model = nil,   -- works better with a fast model like gpt-4.1
		default_agent = nil, -- Uses the current mode when nil
		instructions = nil, -- Use built-in instructions if nil
	},
}
-- Default configuration with all available options
local function vimpack_setup_opencode()
	vim.pack.add({
		{ src = "https://github.com/sudo-tee/opencode.nvim" }
	})
	require('opencode').setup(opencode_opt)
end

local function lazy_setup_opencode()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_opencode()
else
	lazy_setup_opencode()
end
