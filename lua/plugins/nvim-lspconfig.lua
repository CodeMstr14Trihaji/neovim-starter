-- Ini adalah file konfigurasi lsp Anda (misalnya lua/plugins/lsp.lua atau sejenisnya)
return {
  {
    "neovim/nvim-lspconfig",
    -- Pastikan cmp-nvim-lsp ada di dependencies ini atau di tempat lain
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Pastikan ini terinstal dan dimuat
      "WieeRd/auto-lsp.nvim", -- Karena on_attach Anda dari sini
      -- tambahkan dependencies lain yang mungkin Anda miliki untuk LSP/completion
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Inisialisasi capabilities dari Neovim (ini sudah termasuk signatureHelp secara default)
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Jika Anda menggunakan nvim-cmp dengan cmp-nvim-lsp,
      -- panggil default_capabilities() untuk melengkapinya dengan kemampuan yang dibutuhkan cmp.
      local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_nvim_lsp_ok then
        -- Gunakan vim.tbl_deep_extend untuk menggabungkan tanpa menghapus yang sudah ada
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
      end

      -- Ambil on_attach handler dari auto-lsp.nvim
      local on_attach = require("auto-lsp.lsp.handlers").on_attach

      -- Konfigurasi clangd
      lspconfig.clangd.setup({
        on_attach = on_attach, -- Gunakan on_attach dari auto-lsp.nvim
        capabilities = capabilities, -- Pass capabilities yang sudah lengkap
        -- Anda tidak perlu menyetel 'cmd' secara eksplisit di sini jika Mason yang mengelola
        -- Karena Mason secara otomatis membuat wrapper .CMD atau symlink yang benar.
        -- Cukup hapus baris 'cmd = { "..." }' jika ada di lspconfig.clangd.setup Anda
        -- Kecuali Anda punya alasan sangat spesifik untuk override Mason.
      })

      -- Konfigurasi lua_ls
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities, -- Pass capabilities yang sudah lengkap
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "spec" }
            },
            format = {
              enable = false
            },
            hint = {
              arrayIndex = "Disable",
              await = true,
              enable = false,
              paramName = "Disable",
              paramType = true,
              semicolon = "All",
              setType = false
            },
            runtime = {
              special = {
                spec = "require"
              },
              version = "LuaJIT"
            },
            telemetry = {
              enable = false
            },
            workspace = {
              checkThirdParty = false
            }
          }
        }
      })

      -- Konfigurasi pyright
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities, -- Pass capabilities yang sudah lengkap
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "off",
              useLibraryCodeForTypes = true
            }
          }
        }
      })
    end,
  },
  -- Pastikan auto-lsp.nvim juga didefinisikan sebagai plugin di sini
  {
    "WieeRd/auto-lsp.nvim",
    opts = {} -- Jika Anda memiliki opsi khusus untuk auto-lsp.nvim, tempatkan di sini
  },
  -- Pastikan nvim-cmp dan cmp-nvim-lsp juga didefinisikan sebagai plugin
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    opts = {} -- Opsi nvim-cmp Anda
  }
}