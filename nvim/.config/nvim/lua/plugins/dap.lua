local Dap = nil
local Dapui = nil
DapuiStatus = false

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "▶",
	texthl = "DiagnosticSignWarn",
	linehl = "Visual",
	numhl = "",
})

local masondap_opt = {
	ensure_installed = {},
	automatic_installation = false,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,

		-- python
		python = function(config)
			require("daps.debugpy").setup(Dap, config)
		end,

		-- c, cpp, rust
		codelldb = function(config)
			require("daps.bin").setup(Dap, config)
		end,
	},
}

local dapui_opt = {
	icons = {
		expanded = "▾",
		current_frame = "▾",
		collapsed = "▸",
	},
	element_mappings = {},
	mappings = {
		-- edit = 'e',
		expand = { "<CR>", "<2-LeftMouse>" },
		-- open = 'o',
		-- remove = 'd',
		-- repl = 'r',
		-- toggle = 't'
	},
	force_buffers = true,
	expand_lines = true,
	controls = {
		enabled = true,
		element = "console",
		icons = {
			disconnect = " ",
			pause = " ",
			play = " ",
			run_last = " ",
			step_back = " ",
			step_into = " ",
			step_out = " ",
			step_over = " ",
			terminate = " ",
		},
	},
	layouts = {
		{
			elements = {
				"console",
				"repl"
			},
			size = 0.4,
			position = "bottom",
		},
		{
			elements = {
				-- "scopes",
				"breakpoints",
				"stacks",
				"watches"
			},
			size = 0.3,
			position = "left",
		},
	},
	floating = {
		max_height = 0.8,
		max_width = 0.8,
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
	wrap = false,
}

local function config_dap_listener(dap, dapui)
	dap.listeners.before.attach.dapui_config = function()
		Dapui_Status = true
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		Dapui_Status = true
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
		Dapui_Status = false
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
		Dapui_Status = false
	end
	dap.listeners.before.disconnect.dapui_config = function()
		dapui.close()
		Dapui_Status = false
	end
end

local function config_dap_keymaps(dap)
	vim.keymap.set("n", "<F5>", dap.continue, { desc = "Dap continue" })
	vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Dap terminate" })
	vim.keymap.set("n", "<F7>", dap.run_last, { desc = "Dap last" })
	-- vim.keymap.set('n', '<F8>', dap.repl.open, { desc = 'Debug REPL' })
	vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Dap toggle breakpoint" })
	vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Dap step over" })
	vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Dap step into" })
	vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Dap step out" })
	vim.keymap.set("n", "<F13>", dap.step_back, { desc = "Dap step back" })
end

local function vimpack_setup_dap()
	vim.pack.add({
		{ src = "https://github.com/mfussenegger/nvim-dap" },
		{ src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
		{ src = "https://github.com/rcarriga/nvim-dap-ui" },
		{ src = "https://github.com/nvim-neotest/nvim-nio" },
	})

	Dap = require("dap")
	Dapui = require("dapui")

	vim.api.nvim_create_autocmd("BufRead", {
		group = vim.api.nvim_create_augroup("SetupDap", { clear = true }),
		once = true,
		callback = function ()
			require("mason-nvim-dap").setup(masondap_opt)
			require("dapui").setup(dapui_opt)
		end,
	})

	config_dap_listener(Dap, Dapui)

	config_dap_keymaps(Dap)
end

local function lazy_setup_dap()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_dap()
else
	lazy_setup_dap()
end

