local Enable = true

if Enable == false then return end

if not vim.fn.has("nvim-0.7") == 1 then return end

local autopairs_opt = {
	fast_wrap = {
		map = '<M-e>',
		chars = { '{', '[', '(', '"', "'" },
		pattern = [=[[%'%"%>%]%)%}%,]]=],
		end_key = '$',
		before_key = 'h',
		after_key = 'l',
		cursor_pos_before = true,
		keys = 'qwertyuiopzxcvbnmasdfghjkl',
		manual_position = true,
		highlight = 'Search',
		highlight_grey= 'Comment'
	}
}

local function vimpack_setup_autopairs()
	vim.pack.add({
		{ src = "https://github.com/windwp/nvim-autopairs" }
	})

	vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
		group = vim.api.nvim_create_augroup("SetupAutoPairs", { clear = true }),
		once = true,
		callback = function()
			require('nvim-autopairs').setup(autopairs_opt)
		end
	})
end

local function lazy_setup_autopairs()
end

if vim.fn.has("nvim-0.12") == 1 then
	vimpack_setup_autopairs()
else
	lazy_setup_autopairs()
end
