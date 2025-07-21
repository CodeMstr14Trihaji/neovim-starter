vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.defer_fn(function()
    local clients = vim.lsp.get_clients()

      local msg = "LSP aktif untuk C++:\n"
      local count = 0

      for _, client in ipairs(clients) do
        msg = msg .. "  • " .. client.name .. "\n"
        count = count + 1
      end

      if count == 0 then
        msg = "⚠️ Tidak ada LSP aktif untuk C++"
      end

      vim.notify(msg, vim.log.levels.INFO, { title = "LSP C++" })
    end, 200)
  end
})
