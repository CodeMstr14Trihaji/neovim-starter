-- lua/cpp.lua

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    local is_windows = vim.loop.os_uname().version:match("Windows")
    local exe_ext = is_windows and ".exe" or ""
    local run_cmd = is_windows and "%<" or "./%<"

    -- F5: Compile + Run
    vim.keymap.set("n", "<F5>", function()
      vim.cmd("w")
      vim.cmd("belowright split | terminal g++ % -o %<" .. exe_ext .. " && " .. run_cmd)
    end, { buffer = true, noremap = true, silent = true })

    -- F6: Hanya Run
    vim.keymap.set("n", "<F6>", function()
      vim.cmd("belowright split | terminal " .. run_cmd)
    end, { buffer = true, noremap = true, silent = true })

    -- F7: Hanya Compile
    vim.keymap.set("n", "<F7>", function()
      vim.cmd("w")
      vim.cmd("belowright split | terminal g++ % -o %<" .. exe_ext)
    end, { buffer = true, noremap = true, silent = true })
  end,
})
