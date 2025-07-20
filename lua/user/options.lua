-- lua/user/options.lua
-- custom oprion disini

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Opsi utama
local opt = vim.opt

-- Tinggi command line (disembunyikan jika 0, tapi butuh plugin yang support)
opt.cmdheight = 0

-- Indentasi
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- UI
opt.showmode = false
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.showtabline = 2  -- tab selalu terlihat (untuk bufferline dll)
vim.opt.list=true;

-- Searching
opt.ignorecase = true
opt.smartcase = true

-- Paksa show tabline
vim.schedule(function()
  vim.opt.showtabline = 2
end)

