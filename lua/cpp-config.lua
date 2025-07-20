-- lua/cpp.lua

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    local is_windows = vim.loop.os_uname().version:match("Windows")
    local exe_ext = is_windows and ".exe" or ""
    local run_cmd = is_windows and "%<" or "./%<"

    -- menggunakan freeopen(input.txt & output.txt)
    -- F4: run with file
    vim.keymap.set("n", "<F4>", function()
      vim.cmd("w") -- Simpan file cpp
      local filename = vim.fn.expand("%:t:r")
      local exe_ext = vim.loop.os_uname().version:match("Windows") and ".exe" or ""
      local run_cmd = filename .. exe_ext

      vim.fn.jobstart(run_cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_exit = function()
          -- reload output.txt silently if it's already open
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_get_name(buf):match("output%.txt$") then
              vim.api.nvim_buf_call(buf, function()
                vim.cmd("checktime")
              end)
            end
          end
        end,
      })
    end, { buffer = true, noremap = true, silent = true })



    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "output.txt",
      command = "checktime"
    })

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


  --/*------------------------------------------*\
  -- CMD untuk IO cepat, jendela terpisah
  --\*------------------------------------------*/
    vim.api.nvim_create_user_command("CppIOView", function()
  local current = vim.api.nvim_buf_get_name(0)

  -- Pastikan file aktif adalah C++
  if not current:match("%.cpp$") then
    print("Bukan file C++")
    return
  end

  -- Helper: cek apakah buffer sudah dibuka
  local function buf_opened(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_name(buf):match(name) then
        return true
      end
    end
    return false
  end

  -- Split vertikal untuk input/output
  vim.cmd("vsplit")
  vim.cmd("wincmd l") -- ke kolom kanan

  if not buf_opened("input%.txt$") then
    vim.cmd("edit input.txt")
  else
    vim.cmd("b input.txt")
  end

  vim.cmd("split")
  if not buf_opened("output%.txt$") then
    vim.cmd("edit output.txt")
  else
    vim.cmd("b output.txt")
  end

  vim.cmd("wincmd h") -- kembali ke file utama
end, {})
-- end comand IO Cepat


  end,
})
