-- pi bridge

local pi_bridge_opt = {}

local function vimpack_setup_pi_bridge()
	vim.pack.add({
		{ src = "https://github.com/dabstractor/pi-nvim-bridge" }
	})

	require("pi-bridge").setup(pi_bridge_opt)
end

local function lazy_setup_pi_bridge()

end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_pi_bridge()
else
	lazy_setup_pi_bridge()
end

