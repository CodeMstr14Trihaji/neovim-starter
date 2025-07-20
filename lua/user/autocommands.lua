-- custom auto comman disini
vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175,a:ver90",
	desc = "Set cursor back to beam when leaving Neovim.",
})

-- Disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "dbout", "dbui", "http", "httpResult", "lazy" },
	callback = function()
		local opt = vim.opt
		opt.number = false -- Print line number
		opt.preserveindent = false -- Preserve indent structure as much as possible
		opt.relativenumber = false
	end,
})

if pcode.themes then
	local theme = ""
	for _, value in pairs(pcode.themes or {}) do
		theme = value
	end
	vim.cmd("colorscheme " .. theme)
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})

