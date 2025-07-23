-- File: lua/user/macro_notify.lua (atau bagian config mana pun)
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    vim.notify("🎥 Mulai merekam macro!", vim.log.levels.INFO, { title = "Macro Recording" })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    vim.notify("📼 Macro selesai direkam.", vim.log.levels.INFO, { title = "Macro Recording" })
  end,
})




-- -- Floating notifikasi recording di tengah layar
-- local function show_macro_float(msg)
--   local buf = vim.api.nvim_create_buf(false, true)
--   local width = #msg + 4
--   local height = 1
--   local opts = {
--     relative = "editor",
--     width = width,
--     height = height,
--     row = vim.o.lines / 2 - 1,
--     col = (vim.o.columns - width) / 2,
--     style = "minimal",
--     border = "single",
--   }

--   local win = vim.api.nvim_open_win(buf, false, opts)
--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "🎥 " .. msg })
--   vim.defer_fn(function()
--     vim.api.nvim_win_close(win, true)
--   end, 1000) -- tutup setelah 1 detik
-- end

-- vim.api.nvim_create_autocmd("RecordingEnter", {
--   callback = function()
--     show_macro_float("MULAI MEREKAM")
--   end,
-- })

-- vim.api.nvim_create_autocmd("RecordingLeave", {
--   callback = function()
--     show_macro_float("REKAMAN SELESAI")
--   end,
-- })