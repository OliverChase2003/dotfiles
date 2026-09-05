local last_im = 'us'

local function check_ibus_gtk_plugin()
	if vim.fn.executable("gext") ~= 1 then
		return false
	end

	local out = vim.fn.system({ "gext", "list", "--only-uuid" })
	return vim.fn.stridx(out, "input-source-dbus-interface@raiden_fumo") ~= -1
end

local function check_ibus()
	local if_ibus = vim.fn.executable("ibus-daemon") == 1
	local if_gtk_plugin = check_ibus_gtk_plugin()
	return if_ibus and if_gtk_plugin
end

local function check_fcitx()
	return false
end

local function get_current_ibus()
    if vim.fn.executable("gdbus") ~= 1 then
        return 'us'
    end

    local out = vim.fn.system({
        "gdbus", "call", "--session",
        "--dest", "org.gnome.Shell",
        "--object-path", "/raiden_fumo/InputSources",
        "--method", "raiden_fumo.InputSources.Get",
    })

    local current = out:match("%('(.-)',?%)")
    return current
end

local function switch_to_rime()
	if check_ibus() then
		vim.fn.jobstart({
			"gdbus", "call", "--session",
			"--dest", "org.gnome.Shell",
			"--object-path", "/raiden_fumo/InputSources",
			"--method", "raiden_fumo.InputSources.Set",
			"rime"
		})
	elseif check_fcitx() then
		-- nothing
	end
end

local function switch_to_us()
	if check_ibus() then
		vim.fn.jobstart({
			"gdbus", "call", "--session",
			"--dest", "org.gnome.Shell",
			"--object-path", "/raiden_fumo/InputSources",
			"--method", "raiden_fumo.InputSources.Set",
			"us"
		})
	elseif check_fcitx() then
		-- nothing
	end
end

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		if last_im == 'rime' then
			switch_to_rime()
		elseif last_im == 'us' then
			switch_to_us()
		end
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			last_im = get_current_ibus()
			switch_to_us()
		end,
	}
)

vim.api.nvim_create_autocmd(
	{ "CmdlineLeave", "TermLeave" },
	{
		callback = function()
			switch_to_us()
		end,
	}
)

local lost_gain_time = nil
vim.api.nvim_create_autocmd("FocusGained", {
	callback = function()
		local now = vim.uv.hrtime()
		local lost_time_ms = (now - lost_gain_time) / 1e6

		-- switch im will lost focus, add 500ms delay to escape
		if lost_time_ms < 500 then
			return
		end

		local mode = vim.fn.mode()
		local switch_enable = mode == 'i' -- insert mode
			or mode == 'c' -- command line mode
			or mode == 't' -- terminal mode

		if switch_enable then
			if last_im == 'rime' then
				switch_to_rime()
			else
				switch_to_us()
			end
		else
			switch_to_us()
		end
	end,
})

vim.api.nvim_create_autocmd("FocusLost", {
	callback = function()
		lost_gain_time = vim.uv.hrtime()
	end,
})
