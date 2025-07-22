return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Hapus semua baris 'pcall(vim.keymap.del, ...)' yang sebelumnya kita tambahkan.
      -- Ini akan membiarkan keymap default nvim-dap atau plugin lain untuk disetel.

      -- Adapter C/C++
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb", -- path ke codelldb.exe
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        }
      }

      -- Konfigurasi C dan C++
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            local filename = vim.fn.expand("%:r")
            return vim.fn.getcwd() .. "/" .. filename -- Asumsi nama executable = nama file sumber tanpa ekstensi
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp


      -- Tambahkan keymap "Compile + Debug" secara langsung di sini
      -- Ini akan menimpa (override) keymap '<leader>dd' default jika ada, atau membuatnya jika tidak ada.

--       vim.keymap.set('n', '<leader>dd', function()
--      vim.cmd('wa') -- Simpan semua buffer yang dimodifikasi (PENTING!)

--     local file = vim.fn.expand('%')
--     if vim.fn.filereadable(file) and (vim.fn.fnamemodify(file, ':e') == 'cpp' or vim.fn.fnamemodify(file, ':e') == 'c') then
--         local base_name = vim.fn.fnamemodify(file, ':r')
--         local output_file_path = base_name

--         if vim.fn.has("win32") == 1 then
--             output_file_path = output_file_path .. ".exe"
--         end

--         -- Gunakan vim.fn.system() untuk capture output kompilasi (lebih baik dari os.execute)
--         -- Tetap gunakan kutip ganda untuk path
--         local command = string.format('g++ -g -O0 -std=c++23 "%s" -o "%s"', file, base_name)
--         print('Compiling: ' .. command)
--         local compile_output = vim.fn.system(command)

--         if vim.v.shell_error == 0 then -- Cek error pakai vim.v.shell_error
--             print('✅ Save + Compile + Debug Successful!')
--             if compile_output ~= "" then
--                 vim.notify("Compiler output (warnings/info):\n" .. compile_output, vim.log.levels.INFO)
--             end

--             require('dap').run({
--                 name = "Launch file",
--                 type = "codelldb", -- Sesuai dengan definisi adapter Anda
--                 request = "launch",
--                 program = output_file_path,
--                 cwd = vim.fn.getcwd(), -- pastikan ini
--                 stopOnEntry = false, -- bagusnya sih true, tapi entah kenapa kalau true jadi error terus, yaudah di false in aja
--                 args = {},
--                 console = "integratedTerminal",
--                 -- Hapus baris 'console' untuk sementara, biar codelldb yang mutusin defaultnya (seperti di setup lama Anda)

--             })
--         else
--             print('❌ Compilation failed!')
--             vim.notify("Compilation failed:\n" .. compile_output, vim.log.levels.ERROR, { title = "C/C++ Debug Compile Error" })
--         end
--     else
--         print('Not a C/C++ file or file does not exist. Debugging skipped.')
--     end
-- end, { desc = "Debug: Compile + Launch" })



 vim.keymap.set('n', '<leader>dd', function()
    vim.cmd('wa') -- Simpan semua buffer yang dimodifikasi (PENTING!)
    local filename = vim.fn.expand("%:r")
    local filepath = vim.fn.expand("%:p")
    local output_name = filename -- Nama executable hasil kompilasi

    local output_path = vim.fn.getcwd() .. "/" .. output_name
    local cmd = string.format('g++ -g -O0 -std=c++23 "%s" -o "%s"', filepath, output_path) -- <<< Perhatikan ini

    local result = os.execute(cmd) -- <<< Perhatikan ini
    if result == 0 then
        dap.run({
            name = "Launch file",
            type = "codelldb", -- <<< Perhatikan ini
            request = "launch",
            program = output_path,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
        })
    else
        print("❌ Compile failed!")
    end
 end, { desc = "Debug: Compile + Launch" })



    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      -- local dap = require("dap") -- Tidak perlu jika tidak ada keymap dap yang didefinisikan di sini

      -- Hapus seluruh bagian opts.defaults["<leader>d"]
      -- Biarkan Which-Key mengelola keymap lainnya atau biarkan DAP mengatur keymapnya sendiri.
      -- Jika Anda memiliki keymap which-key lainnya yang tidak terkait debugger, biarkan mereka di sini.
      -- Contoh: opts.defaults["<leader>f"] = { name = "File" ... }
    end,
  },
}