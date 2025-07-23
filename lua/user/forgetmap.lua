-- user/forgetmap.lua

local M = {}

-- Mapping daftar hint
local forget_map = {
	Copy = "Normal: yy\nVisual: y\nClipboard: Ctrl+C",
	Paste = "Normal: p\nClipboard: Ctrl+V or Shift+Insert",
	Delete = "Normal: dd\nVisual: d\nLine Delete: D",
	Save = ":w\nLeader: <leader>w",
	Quit = ":q\nLeader: <leader>q\nForce Quit: :q!",
	Undo = "u",
	Redo = "<C-r>",
	Move = "gg (atas), G (bawah), H/M/L (screen)",
	Window = "<C-w> + h/j/k/l or <C-w>arrow",
	Search = "/text  lalu n/N\nGanti: :%s/old/new/g",
	Visual = "v (karakter), V (baris), <C-v> (blok)",
	Indent = "> dan < di Visual mode",
	Comment = "gc di Visual/Normal (butuh plugin)",
	Replace = "r<char> (karakter), R (mode ganti)",
	SelectAll = "ggVG",
	Buffers = ":bnext / :bprev / :bd",
	Files = ":e <file> | :Ex | :NvimTreeToggle",
	Navigate = "<C-u>up | <C-d>down | <C-y>Up view | <C-e>Down view",
	ExitSearchMode = "noh",
	FullNavigate = "<C-b>Max up | <C-f>",
	SeeDiagnostic = "<C-w> d",
	ExitSuggestBox = "<C-e>",
	BlockAndWrite = "<Block-c>",
	WriteMode = "i",
	NormalMode = "Esc",
	MainMenu = "Alpha",
	SearchText = "?",
	ReplaceText = [[ 
    Block + v → :'<,'>s/old/new/{flags}
    Seluruh file → :%s/old/new/{flags}
    Flags:
        g = global (semua)
        i = ignore case
        c = confirm per ganti
    ]],
	Tab = "Right: Block visual + >\nLeft: Block visual + <",
	CommandHistory = "q:",
	RecordMacro = [[
        🔴 Rekam Macro di Normal Mode:
        - `qa` mulai rekam ke register `a`
        - Lakukan aksi seperti biasa (pindah, edit, hapus, dsb)
        - `q` untuk berhenti merekam
        - `@a` untuk jalankan macro dari register `a`

        🔁 Jalankan Macro:
        - `@a` → jalankan macro dari register `a`
        - `@@` → jalankan macro terakhir
        - `5@a` → jalankan macro `a` sebanyak 5 kali

        📌 Tips Lanjutan:
        - Visual Mode: blok teks lalu `:'<,'>normal @a` untuk eksekusi per baris
        - Jalankan macro di banyak baris: `:10,20normal @a`
        - Cek isi macro: `:registers a`
        - Kosongkan macro: `qaq`

        🧠 Register tersedia: a–z (huruf kecil). Bisa punya banyak macro!
        ⚠️ Jangan mapping ulang tombol `q` di Normal Mode agar macro tetap berfungsi.
        ]],
	CenterView = "zz",
	BackTolastWrite = "g + i",
	CaseToUpper = [[
    Ubah huruf ke Kapital
    gUiw → Uppercase satu kata (inner word)
    ]],

	CaseToLower = [[
    Ubah huruf ke huruf kecil
    guiw → Lowercase satu kata (inner word)
    ]],

	CaseToggle = [[
    Toggle besar-kecil huruf
    g~w  → Toggle case satu kata
    g~$  → Toggle case sampai akhir baris
    ]],

	SelectParagraph = [[
    Seleksi satu paragraf
    vip → Visual select inner paragraph
    ]],

	ChangeInnerWord = [[
    Ganti isi satu kata
    ciw → Change inner word (hapus lalu masuk insert mode)
    ]],

	IndentLines = [[
    Indentasi Baris
    >> → Indent ke kanan
    << → Indent ke kiri
    ]],

	JoinLines = [[
    Gabungkan baris
    J → Gabungkan baris saat ini dengan baris di bawahnya
    ]],

	SaveAndQuit = [[
    Simpan dan keluar
    ZZ → Simpan perubahan dan keluar dari buffer (sama dengan :wq)
    ]],

	QuitWithoutSave = [[
    Keluar tanpa simpan: q!
    ]],

	Buffer = [[
	Buffer option
	<leader> b + selectOption
	]],

	ToogleWordWrap = "Word Wrap <A-z>",

	CopyLine = "Copy line: yyp",

	MoveFile = ":saveas path/baru/namafile.ext",

	InsertNav = "Dari mode insert tanpa escape : <A> h/j/k/l",

	TempNav = "1 command, lalu kembali ke insert mode: <C> o",

	InsertEnter = "<C-o>o",

	AdvancedChangeLine = [[
	cmd for fixed line: <line>
	for relative  line (mode normal): 
	<num>k => keatas {num} kali
	<num>j => kebawah {num} kali
	d<num>k => hapus {num} baris keatas
	d<num>j => hapus {num} baris kebawah
	c<num>k => ganti {num} baris keatas
	c<num>j => ganti {num} baris kebawah
    y<num>k => copy {num} baris keatas
    y<num>j => copy {num} baris kebawah
	]],
}

-- Register semua command :ForgetX
function M.setup()
	for key, msg in pairs(forget_map) do
		vim.api.nvim_create_user_command("Forget" .. key, function()
			vim.notify("🔑 " .. msg, vim.log.levels.INFO, {
				title = "Keymap Hint: " .. key,
			})
		end, {})
	end

	-- Tambahan: :Forget buat lihat semua kategori
	vim.api.nvim_create_user_command("Forget", function()
		local keys = {}
		for k, _ in pairs(forget_map) do
			table.insert(keys, k)
		end
		table.sort(keys)
		vim.notify("Available: " .. table.concat(keys, ", "), vim.log.levels.INFO, {
			title = "Forget Help",
		})
	end, {})
end

return M
