local function vimpack_setup_icon()
	vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-web-devicons" } })
	require('nvim-web-devicons').setup()
end

local function lazy_setup_icon()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_icon()
else
	lazy_setup_icon()
end
