# NEOVIM Introduction
---
<br/>

## Apa itu NEOVIM
nvim adalah singkatan dari Neovim, yaitu sebuah text editor (editor teks) yang merupakan fork atau turunan dari Vim, namun lebih modern, modular, dan extensible.

### 🔍 Penjelasan Singkat:
Vim adalah editor teks terkenal yang berjalan di terminal, terkenal karena kecepatannya dan navigasi berbasis keyboard.

Neovim dikembangkan untuk:
- Memperbaiki arsitektur Vim yang lama.
- Memberi dukungan yang lebih baik untuk plugin modern, seperti LSP (Language Server Protocol), debugging, dan integrasi IDE.
- Mempermudah kustomisasi dengan bahasa seperti Lua.

### 🧠 Fitur Utama Neovim:
- 💡 LSP (Language Server)	Fitur seperti autocomplete, go-to definition, linting.
- 🔌 Plugin Modern	Mendukung plugin dengan Lua, lebih cepat dan powerful.
- ⚙️ Konfigurasi Lua	Bisa dikonfigurasi dengan Lua (lebih bersih dan efisien dibanding Vimscript).
- 🧩 Ekosistem Plugin Aktif	Banyak plugin seperti telescope.nvim, nvim-tree, lualine, dll.
- 📟 Terminal Terintegrasi	Bisa buka terminal langsung di dalam Neovim.
- 🖥️ GUI Support (opsional)	Bisa dipakai dengan GUI frontend seperti Neovide, LunarVim, dll.

### 🚀 Cocok Untuk Siapa?
- Cocok banget buat programmer yang suka kerja cepat, efisien, dan dengan keyboard-centric.
- Bagi pengguna Vim yang ingin fitur modern seperti autocompletion dan debugging, Neovim adalah upgrade terbaik.

Tentu! Berikut contoh penjelasan untuk README-mu yang menjelaskan **kenapa Neovim sangat cocok untuk Competitive Programmer**, dan **kenapa dia sangat cepat**:

---
<br/>

## 🚀 Kenapa Neovim Sangat Cocok untuk Competitive Programming?

Neovim adalah editor teks modern berbasis terminal yang dirancang untuk kecepatan, efisiensi, dan fleksibilitas — tiga hal yang sangat penting bagi seorang competitive programmer. Berikut alasan utamanya:

### ✅ 1. Super Cepat dan Ringan

Neovim berjalan di dalam terminal dan memiliki waktu startup yang hampir instan. Dibandingkan dengan IDE besar seperti VS Code atau IntelliJ:

- **Tanpa GUI berat**: Neovim hanya fokus pada teks, tanpa embel-embel visual yang memperlambat.
- **Responsif di mesin spek rendah**: Cocok digunakan bahkan di laptop jadul atau lingkungan server.

### ✅ 2. Navigasi Cepat Tanpa Mouse

Segala sesuatu di Neovim dirancang untuk dilakukan **dengan keyboard**:

- Navigasi antar file, berpindah tab, pindah antar fungsi — semua bisa dilakukan dalam hitungan detik.
- Minimalkan waktu yang terbuang karena bolak-balik antara mouse dan keyboard.

### ✅ 3. Bisa Disesuaikan dengan Workflow Competitive Programming

Neovim sangat fleksibel dan bisa dikonfigurasi untuk mendukung:

- 🔘 Compile dan run dengan satu tombol (misalnya: `F5`, `F3`, dll).
- 📥 Input otomatis dari file `input.txt` dan output ke `output.txt`.
- 📂 Snippets khusus C++, Python, dsb, agar bisa fokus langsung ke logika soal.
- 📄 Plugin seperti `telescope` untuk mencari file cepat, atau `nvim-lspconfig` untuk bantuan coding seperti IDE.

### ✅ 4. Hemat Waktu Saat Kontes

Setiap detik sangat berarti saat lomba. Dengan Neovim, kamu bisa:

- Membuka banyak file sekaligus dengan tabs/split.
- Menyusun test case otomatis dengan keymap yang kamu buat sendiri.
- Menyimpan template C++ atau Python hanya dalam 1 shortcut.

### ✅ 5. Tidak Perlu Tinggalkan Terminal

Neovim mendukung terminal terintegrasi (`:terminal`), sehingga:

- Kamu bisa **compile, run, dan debug langsung di dalam editor**.
- Tidak perlu ALT+TAB ke terminal lain — semuanya ada di satu tempat.

---
<br/>

## ⚡ Kenapa Neovim Sangat Cepat?

Kecepatan Neovim berasal dari desain dan arsitekturnya yang minimalis dan efisien:

- Dibuat dengan **C** dan **Lua**, bukan Electron.
- Tidak perlu GUI, hanya terminal — hemat resource.
- Mendukung **asynchronous processing**, jadi plugin tidak menghambat kinerja utama.
- Konfigurasi modular dan ringan.


Kalau kamu competitive programmer yang ingin kontrol penuh atas lingkungan ngodingmu, **Neovim adalah pilihan yang tepat**. Kombinasi kecepatan, efisiensi, dan kemampuan custom-nya membuat kamu bisa lebih fokus menyelesaikan soal — bukan melawan editor.

---
<br/>

# Tahap Instalasi

## 2.1 | Install scoop
Untuk bisa menginstal nvim dengan mudah, pertama-tama kita perlu mengistall aplikasi yang bernama scoop. Scoop adalah package manager untuk Windows yang membuat instalasi software dari command line jadi super gampang dan rapi — mirip seperti apt di Linux atau brew di macOS.

Dengan Scoop, kamu bisa install aplikasi terminal (seperti neovim, git, node, dll) hanya dengan satu perintah:

```bash
scoop install neovim
```
Kenapa Kita Pakai Scoop untuk Install Neovim?
Karena:
- 📦 Mudah & cepat: Tidak perlu cari-cari file .exe di internet.
- 🚫 Tanpa bloatware: Tidak ada iklan, bundling, atau embel-embel lain.
- 🧹 Instalasi rapi: Semua aplikasi diatur dalam folder khusus (C:\Users\<user>\scoop), gampang dihapus kalau ingin uninstall total.
- 🔁 Auto-update: Dengan scoop update, kamu bisa update semua tool CLI termasuk Neovim.

Atau, semisal kalau kamu butuh tambahan tool seperti clang, gcc, atau python buat competitive programming, tinggal:

```bash
scoop install gcc python git
```

Nah, cara install scoop sendiri mudah, kita cukup pergi ke situs resmi dari scoop, yaitu [scoop.sh](https://scoop.sh/), lalu disana akan diberikan syntax yang perlu kita copy-paste ke terminal kita, untuk memasangnya. 

Lebih baik kunjungi situs resmi jika ada perubahan! Syntaxnya adalah seperti ini:

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
