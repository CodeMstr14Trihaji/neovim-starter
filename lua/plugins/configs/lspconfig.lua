local M = {}

-- capabilities dan on_attach untuk digunakan ulang
M.on_attach = function(_, _)
  -- Bisa dibiarkan kosong dulu, atau isi sesuai kebutuhanmu
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M
