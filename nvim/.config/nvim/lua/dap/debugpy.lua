local debugpy = {}

function debugpy.setup(dap, config)
	require('mason-nvim-dap').default_setup(config)

	config.adapters = {
		type = 'executable',
		command = 'python3',
		args = { '-m', 'debugpy.adapter' },
	}

	dap.configurations.python = {
		{
			type = 'python',
			request = 'launch',
			name = 'Launch file',
			program = '${file}',
			pythonPath = function()
				return vim.fn.exepath('python3') or 'python'
			end,
			terminal = "integrated",
		},
	}
end

return debugpy
