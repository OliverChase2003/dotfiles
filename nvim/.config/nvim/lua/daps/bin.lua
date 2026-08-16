local bin = {}

local function get_bin_path(search_sub_dirs)
	local project_dir = vim.fn.getcwd()
	for _, sub_dir in ipairs(search_sub_dirs) do
		local dir = project_dir .. '/' .. sub_dir
		local result = vim.fn.systemlist(
			'find ' .. dir .. ' -maxdepth 1 -type f -executable 2>/dev/null'
		)
		if #result > 0 then
			return result[1]
		end
	end

	return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
end

local function config_adapters(dap)
	-- gdb
	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",
		args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
	}

	-- rust-gdb
	dap.adapters["rust-gdb"] = {
		type = "executable",
		command = "rust-gdb",
		args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
	}

	-- probe-rs
	dap.adapters["probe-rs-debug"] = {
		type = "server",
		port = "${port}",
		executable = {
			command = "probe-rs",
			args = { "dap-server", "--port", "${port}" },
		},
	}

end

local function config_dapcfg(dap)
	dap.configurations.rust = {
		{
			name = "Probe-rs Debug",
			type = "probe-rs-debug",
			request = "launch",
			cwd = "${workspaceFolder}",
			beforeLaunch = function()
				vim.notify("cargo build...")

				local result = vim.fn.system("cargo build")
				if vim.v.shell_error ~= 0 then
					error("cargo build failed:\n" .. result)
				end
			end,
			chip = "esp32c6",
			flashingConfig = {
				flashingEnabled = true,
				resetAfterFlashing = true,
			},
			coreConfigs = {
				{
					coreIndex = 0,
					programBinary = function()
						return get_bin_path({
							"target/*/debug"
						})
					end,
				},
			},
		},
		{
			name = 'Launch(codelldb)',
			type = 'codelldb',
			request = 'launch',
			program = function()
				return get_bin_path({ 'target/debug' })
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			sourceLanguages = { "rust" },
		},
		{
			name = "Launch(rust-gdb)",
			type = "rust-gdb",
			request = "launch",
			program = function()
				return get_bin_path({ 'target/debug' })
			end,
			args = {}, -- provide arguments if needed
			cwd = "${workspaceFolder}",
			stopAtBeginningOfMainSubprogram = false,
			sourceLanguages = { "rust" },
		},
	}

	dap.configurations.c = {
		{
			name = 'Launch(codelldb)',
			type = 'codelldb',
			request = 'launch',
			program = function()
				return get_bin_path({ 'build', '' })
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			sourceLanguages = { "c" },
		},
		{
			name = 'Launch(gdb)',
			type = 'gdb',
			request = 'launch',
			program = function()
				return get_bin_path({ 'build', '' })
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			sourceLanguages = { "c" },
		},
		{
			name = 'Attach to gdbserver :1234',
			type = 'gdb',
			request = 'attach',
			target = 'localhost:1234',
			program = function()
				return get_bin_path({ 'build', '' })
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			sourceLanguages = { "c" },
		}
	}

	dap.configurations.cpp = dap.configurations.c
end

function bin.setup(dap, config)
	require('mason-nvim-dap').default_setup(config)

	config_adapters(dap)

	config_dapcfg(dap)
end

return bin
