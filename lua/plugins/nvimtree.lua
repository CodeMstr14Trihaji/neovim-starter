return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      -- Konfigurasi lainnya bisa kamu tambah di sini
      -- misalnya:
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    })

    -- Tutup nvim-tree saat dashboard dibuka
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.cmd("NvimTreeClose")
      end,
    })
  end
}
