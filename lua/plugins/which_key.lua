return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function(_, opts)

    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below


    -- hapus keymap q dan Q supaya tidak bentrok dengan macro
    pcall(vim.keymap.del, "n", "q")
    pcall(vim.keymap.del, "n", "Q")

    return opts  -- <== WAJIB: biar opsi default tetap jalan
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
