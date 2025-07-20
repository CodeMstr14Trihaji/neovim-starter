-- init.lua atau config awal kamu
vim.env.PATH = vim.env.PATH .. ';C:\\Program Files\\Git\\cmd'

return {
  -- Tema dan UI
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      require("nvim-tree").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    config = function()
      require("bufferline").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "pojokcodeid/auto-lualine.nvim",
    lazy = false,
    opts = {
      setColor = "auto",
      setOption = "roundedall",
      setMode = 5,
    },
  },

  -- Utility Plugin
  {
    "windwp/nvim-autopairs",
    lazy = false,
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    config = function()
      require("ibl").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
  },
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup()
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  -- Dashboard dan Notifikasi
  {
    "folke/noice.nvim",
    lazy = false,
    config = function()
      require("noice").setup()
    end,
  },
  -- {
  --   "goolord/alpha-nvim",
  --   lazy = false,
  --   opts = {
  --     dash_model = {
  --       [[  __         .__.__                __.__ __   .__           ]],
  --       [[_/  |________|__|  |__ _____      |__|__|  | _|  |_________ ]],
  --       [[\   __\_  __ \  |  |  \\__  \     |  |  |  |/ /  |  \_  __ \]],
  --       [[ |  |  |  | \/  |   Y  \/ __ \_   |  |  |    <|   Y  \  | \/]],
  --       [[ |__|  |__|  |__|___|  (____  /\__|  |__|__|_ \___|  /__|   ]],
  --       [[                     \/     \/\______|       \/    \/     ]],
  --     },
  --   },
  -- },

  -- Format dan LSP
  {
    "pojokcodeid/auto-conform.nvim",
    lazy = false,
    opts = {
      format_on_save = true,
      format_timeout_ms = 5000,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua", "c" })
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {},
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = function(_, opts)
      vim.list_extend(opts.skip_config, {})
      opts.virtual_text = true
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    lazy = false,
    opts = function(_, opts)
      opts.mappings = opts.mappings or {}
      vim.list_extend(opts.mappings, {
        { "<leader>h", "<cmd>nohlsearch<CR>", desc = "󱪿 No Highlight", mode = "n" },
      })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = { hidden = true },
          live_grep = {
            theme = "dropdown",
            only_sort_text = true,
            additional_args = function() return { "--multiline" } end,
          },
        },
      })
    end,
  },

  -- Code runner
  {
    "CRAG666/code_runner.nvim",
    lazy = false,
    config = function()
      require("code_runner").setup({
        filetype = {
          go = "go run $fileName",
        },
      })
    end,
  },

  -- NvimTree Custom
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = function(_, opts)
      return opts
    end,
  },

  -- Tambahan plugin yang tadinya belum diload
  {
    "rafamadriz/friendly-snippets",
    lazy = false,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    lazy = false,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      require("smart-splits").setup({})
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("toggleterm").setup()
    end,
  },
  {
  "nvim-tree/nvim-web-devicons",
  lazy = false,
},
{
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_lua").load({
      paths = vim.fn.stdpath("config") .. "/snippets"
    })
  end
}, 
-- {
--   "lewis6991/gitsigns.nvim",
--   lazy = false,
--   config = function()
--     require("gitsigns").setup {
--       signs = {
--         add          = { text = "+" },
--         change       = { text = "~" },
--         delete       = { text = "-" },
--         topdelete    = { text = "‾" },
--         changedelete = { text = "~" },
--       },
--       signcolumn = true,  -- Tampilkan tanda di kiri
--       numhl      = false, -- Highlight nomor baris
--       linehl     = false, -- Highlight seluruh baris
--       watch_gitdir = {
--         interval = 1000,
--         follow_files = true
--       },
--       current_line_blame = true, -- ⬅️ menampilkan siapa yang terakhir ubah baris
--       current_line_blame_opts = {
--         virt_text = true,
--         virt_text_pos = 'eol', -- bisa diubah ke 'overlay', 'right_align'
--         delay = 100,
--         ignore_whitespace = false,
--       },
--       on_attach = function(bufnr)
--         local gs = package.loaded.gitsigns

--         local function map(mode, l, r, opts)
--           opts = opts or {}
--           opts.buffer = bufnr
--           vim.keymap.set(mode, l, r, opts)
--         end

--         -- Keymaps (opsional)
--         map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview Git hunk" })
--         map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage Git hunk" })
--         map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo stage" })
--         map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset Git hunk" })
--         map('n', '<leader>gb', gs.blame_line, { desc = "Blame line" })
--       end
--     }
--   end
-- }
}
