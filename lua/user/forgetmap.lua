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
	Window = "<C-w> + h/j/k/l",
	Search = "/text  lalu n/N\nGanti: :%s/old/new/g",
	Visual = "v (karakter), V (baris), <C-v> (blok)",
	Indent = "> dan < di Visual mode",
	Comment = "gc di Visual/Normal (butuh plugin)",
	Replace = "r<char> (karakter), R (mode ganti)",
	SelectAll = "ggVG",
	Buffers = ":bnext / :bprev / :bd",
	Files = ":e <file> | :Ex | :NvimTreeToggle",
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
