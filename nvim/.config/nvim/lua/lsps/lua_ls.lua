local lua_ls = {}

function lua_ls.setup()
	vim.lsp.config['lua_ls'] = {
		settings = {
			Lua = {
				-- runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
				diagnostics = { globals = { 'vim' } },
				workspace = {
					library = vim.api.nvim_get_runtime_file('', true),
					checkThirdParty = false
				}
			},
		},
		format = { enable = true }
	}
end

return lua_ls
