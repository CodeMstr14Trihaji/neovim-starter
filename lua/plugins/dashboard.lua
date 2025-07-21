local projects = require("core.projects")

return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "  ▄████▄   ▒█████   ██▀███   ▒█████   ██ ▄█▀",
      " ▒██▀ ▀█  ▒██▒  ██▒▓██ ▒ ██▒▒██▒  ██▒ ██▄█▒ ",
      " ▒▓█    ▄ ▒██░  ██▒▓██ ░▄█ ▒▒██░  ██▒▓███▄░ ",
      " ▒▓▓▄ ▄██▒▒██   ██░▒██▀▀█▄  ▒██   ██░▓██ █▄ ",
      " ▒ ▓███▀ ░░ ████▓▒░░██▓ ▒██▒░ ████▓▒░▒██▒ █▄",
      " ░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒▓ ░▒▓░░ ▒░▒░▒░ ▒ ▒▒ ▓▒",
    }

dashboard.section.buttons.val = {
  dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
  dashboard.button("o", "  Open Project Folder", function() 
    projects.open()
    end),
  dashboard.button("g", "  Grep Text", ":Telescope live_grep<CR>"),
  dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("u", "  Update Plugins", ":Lazy update<CR>"),
  dashboard.button("l", "  Mason LSP", ":Mason<CR>"),
  dashboard.button("p", "  Plugin Manager", ":Lazy<CR>"),
  dashboard.button("s", "  Settings", ":e ~/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

dashboard.section.footer.val = "⚡ Neovim ready to go!"

    -- Center layout
    dashboard.opts.layout[1].val = 8  -- padding top, bisa ubah ke 4–6 kalau mau lebih rapat
    alpha.setup(dashboard.opts)


-- Biar tidak bisa scroll kosong ke bawah
    vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        vim.opt_local.scrolloff = 0       -- supaya buffer ga geser2 ke bawah
        vim.opt_local.wrap = true         -- teks dibungkus
        vim.opt_local.modifiable = false  -- mencegah modifikasi tidak sengaja
    end,
    })


  end,
}