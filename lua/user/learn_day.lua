local uv = vim.loop
local state_file = vim.fn.stdpath("config") .. "/lua/user/learn_day.json"

local function load_state()
	local fd = uv.fs_open(state_file, "r", 438)
	if not fd then
		return { last = "", count = 0, reminders = {} }
	end
	local stat = uv.fs_fstat(fd)
	if stat.size == 0 then
		uv.fs_close(fd)
		return { last = "", count = 0, reminders = {} }
	end
	local raw = uv.fs_read(fd, stat.size, 0)
	uv.fs_close(fd)
	local ok, tbl = pcall(vim.fn.json_decode, raw)
	return ok and tbl or { last = "", count = 0, reminders = {} }
end

local function save_state(st)
	vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
	local fd = uv.fs_open(state_file, "w", 438)
	uv.fs_write(fd, vim.fn.json_encode(st), 0)
	uv.fs_close(fd)
end

local function days_between(date1, date2)
	local pattern = "(%d+)%-(%d+)%-(%d+)"
	local y1, m1, d1 = date1:match(pattern)
	local y2, m2, d2 = date2:match(pattern)
	if not (y1 and m1 and d1 and y2 and m2 and d2) then
		return 0
	end
	local t1 = os.time({ year = tonumber(y1), month = tonumber(m1), day = tonumber(d1) })
	local t2 = os.time({ year = tonumber(y2), month = tonumber(m2), day = tonumber(d2) })
	return math.floor(os.difftime(t2, t1) / (60 * 60 * 24))
end

-- Auto jalankan saat buka Neovim
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local today = os.date("%Y-%m-%d")
		local st = load_state()

		-- Tambah hari belajar jika beda hari
		if st.last ~= today then
			st.last = today
			st.count = st.count + 1
			save_state(st)
			vim.schedule(function()
				vim.notify(("Hari ke-%d belajar C++"):format(st.count), vim.log.levels.INFO)
			end)
		end

		-- Notifikasi pengingat
		for key, date_str in pairs(st.reminders or {}) do
			local sisa = days_between(today, date_str)
			if sisa >= 0 then
				vim.schedule(function()
					vim.notify(("%s tinggal %d hari lagi! 📣"):format(key, sisa), vim.log.levels.WARN)
				end)
			end
		end
	end,
})

-- Tambah reminder
vim.api.nvim_create_user_command("AddReminder", function(opts)
	local name = opts.fargs[1]
	local date = opts.fargs[2] -- Format: YYYY-MM-DD

	if not name or not date or not date:match("^%d%d%d%d%-%d%d%-%d%d$") then
		vim.notify("Format salah. Gunakan: :AddReminder 'Nama Event' YYYY-MM-DD", vim.log.levels.ERROR)
		return
	end

	local st = load_state()
	st.reminders = st.reminders or {}
	st.reminders[name] = date
	save_state(st)

	vim.notify(("Reminder '%s' ditambahkan untuk %s"):format(name, date), vim.log.levels.INFO)
end, {
	nargs = "+",
	desc = "Add reminder: :AddReminder 'Nama Event' YYYY-MM-DD",
})

-- Lihat daftar reminder
vim.api.nvim_create_user_command("ListReminders", function()
	local st = load_state()
	local reminders = st.reminders or {}
	if type(reminders) ~= "table" or vim.tbl_isempty(reminders) then
		vim.notify("Tidak ada reminder disimpan.", vim.log.levels.INFO)
		return
	end

	local msg = "📅 Daftar Reminder:\n"
	local today = os.date("%Y-%m-%d")
	for k, v in pairs(reminders) do
		if type(v) == "string" then
			local sisa = days_between(today, v)
			msg = msg .. ("- %s (%s) → %d hari lagi\n"):format(k, v, sisa)
		end
	end
	vim.notify(msg, vim.log.levels.INFO)
end, {
	desc = "Lihat semua reminder yang tersimpan",
})

-- Hapus reminder
vim.api.nvim_create_user_command("RemoveReminder", function(opts)
	local st = load_state()
	local name = opts.fargs[1]
	if st.reminders and st.reminders[name] then
		st.reminders[name] = nil
		save_state(st)
		vim.notify(("Reminder '%s' telah dihapus."):format(name), vim.log.levels.INFO)
	else
		vim.notify(("Reminder '%s' tidak ditemukan."):format(name), vim.log.levels.ERROR)
	end
end, {
	nargs = "+",
	desc = "Hapus reminder dengan nama tertentu",
})
