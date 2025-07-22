local dap = require("dap")

dap.configurations.cpp = {
  {
    name = "Debug via Make",
    type = "codelldb",
    request = "launch",
    program = function()
      vim.fn.system("make") -- compile dulu
      return vim.fn.getcwd() .. "/code"   -- pakai penamaan static, jadikan code.cpp sebaai file utama
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false, 
  },
}

vim.keymap.set("n", "<leader>dm", function()
  print("🔨 Compiling with make...")
  local output = vim.fn.system("make")
  if vim.v.shell_error ~= 0 then
    print("❌ Compile error:\n" .. output)
  else
    print("✅ Compile success")
  end
end, { desc = "Compile (make)" })
