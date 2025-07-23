-- custom key maps disini
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "]h", '<cmd>lua print("Testing")<cr>', opts)
keymap("n", "f", "<cmd>NvimTreeFindFileToggle<cr><cr><Up>", opts)

-- Di init.lua kamu (atau keymap file) untuk navigasi geser tab
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

-- Shift + Arrow Keys untuk masuk Visual Mode dan berpindah
vim.keymap.set("n", "<S-Left>", "v<Left>")
vim.keymap.set("n", "<S-Right>", "v<Right>")
vim.keymap.set("n", "<S-Up>", "v<Up>")
vim.keymap.set("n", "<S-Down>", "v<Down>")

-- Kalau sudah di visual mode, lanjutkan seleksi dengan arah
vim.keymap.set("v", "<S-Left>", "<Left>")
vim.keymap.set("v", "<S-Right>", "<Right>")
vim.keymap.set("v", "<S-Up>", "<Up>")
vim.keymap.set("v", "<S-Down>", "<Down>")