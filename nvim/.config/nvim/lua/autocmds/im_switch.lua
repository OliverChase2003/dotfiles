local last_im = 'us'

local function check_ibus()
	return vim.fn.executable("ibus-daemon") == 1
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
	if not check_ibus() then
		return
	end
	vim.fn.jobstart({
		"gdbus", "call", "--session",
		"--dest", "org.gnome.Shell",
		"--object-path", "/raiden_fumo/InputSources",
		"--method", "raiden_fumo.InputSources.Set",
		"rime"
	})
end

local function switch_to_us()
	if not check_ibus() then
		return
	end
	vim.fn.jobstart({
		"gdbus", "call", "--session",
		"--dest", "org.gnome.Shell",
		"--object-path", "/raiden_fumo/InputSources",
		"--method", "raiden_fumo.InputSources.Set",
		"us"
	})
end

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		if last_im == 'rime' then
			switch_to_rime()
		end
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		last_im = get_current_ibus()
		switch_to_us()
	end,
})

