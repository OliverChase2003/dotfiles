local editorconfig_file = "/home/oliver/.dotfiles/nvim/.config/nvim/lua/usercmds/.editorconfig"

vim.api.nvim_create_user_command("Edcfg", function()
	if vim.fn.filereadable(editorconfig_file) ~= 1 then
		vim.notify("edcfg: source file not found " .. editorconfig_file, vim.log.levels.ERROR)
		return
	end
	local dest = vim.fn.getcwd() .. "/.editorconfig"
	if vim.fn.filereadable(dest) == 1 then
		local choice = vim.fn.confirm(dest .. " already exists, overwrite?", "&Yes\n&No", 2)
		if choice ~= 1 then return end
	end
	vim.uv.fs_copyfile(editorconfig_file, dest)
	vim.notify("Copied to " .. dest, vim.log.levels.INFO)
end, { desc = "Copy .editorconfig template to cwd" })


local clang_format_file = "/home/oliver/.dotfiles/nvim/.config/nvim/lua/usercmds/.clang-format"

vim.api.nvim_create_user_command("Clangfmt", function()
	if vim.fn.filereadable(clang_format_file) ~= 1 then
		vim.notify("clangfmt: source file not found " .. clang_format_file, vim.log.levels.ERROR)
		return
	end
	local dest = vim.fn.getcwd() .. "/.clang-format"
	if vim.fn.filereadable(dest) == 1 then
		local choice = vim.fn.confirm(dest .. " already exists, overwrite?", "&Yes\n&No", 2)
		if choice ~= 1 then return end
	end
	vim.uv.fs_copyfile(clang_format_file, dest)
	vim.notify("Copied to " .. dest, vim.log.levels.INFO)
end, { desc = "Copy .clang-format template to cwd" })
