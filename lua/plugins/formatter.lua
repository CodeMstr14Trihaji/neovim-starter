return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 3000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      cpp = { "clang_format" },
      c = { "clang_format" },
    },
    formatters = {
      clang_format = {
        command = "clang-format",
        args = { "--style=file" },
      },
    },
  },
}

--[[
📌 Daftar Gaya clang-format yang Bisa Dipakai:

-- Gunakan salah satu:
--   "LLVM"       : Gaya default clang/LLVM project
--   "Google"     : Gaya resmi Google C++
--   "Chromium"   : Digunakan untuk proyek Chromium
--   "Mozilla"    : Untuk kode ala Mozilla
--   "WebKit"     : Digunakan oleh proyek WebKit (Safari engine)
--   "Microsoft"  : Gaya Microsoft C++
--   "GNU"        : Gaya ala GNU
--   "Java"       : Untuk gaya Java-like
--   "Rust"       : Untuk gaya mirip Rust
--   "File"       : Baca dari file .clang-format (direkomendasikan untuk tiap project)



📌 Tips:
-- - Gunakan "File" jika kamu ingin clang-format membaca konfigurasi dari file .clang-format
-- - Kamu bisa menyimpan style custom di file .clang-format per project
-- - Hindari hardcode jika kamu ingin fleksibel antar project
-- - ⚠️ Susah kalau dibuat style based command, mending diatur dengan file .clang-format,
-- - Prioritas style dan setting format berasal dari file .clang-format. Jika tidak ada, maka style akan
    akan menggunakan LLVM sebagai default (tentunya jika sudah tersedai clang-format di PC yang digunakan)

    -- - Periksa versi clang format di terminal : clang-format --version




📌 Contoh isi folder .clang-format:
# Based on Google style, but can be customized further
BasedOnStyle: Google

# Example of some common customizations you might want to add (optional):
# TabWidth: 4
IndentWidth: 4
ColumnLimit: 120
# AlwaysBreakBeforeMultilineStrings: true
BreakBeforeBraces: Attach
AllowShortIfStatementsOnASingleLine: false
# PointerAlignment: Left

]]