local projects = require("core.projects")

return {
	"goolord/alpha-nvim",
	config = function()
		-- Kalau Neovim dibuka dengan file langsung, misalnya:
		-- nvim file.cpp, nvim some_folder/, atau kamu membuka file dari luar Neovim
		-- seperti via Telescope, nvim-tree, dsb.
		-- maka seluruh konfigurasi plugin alpha-nvim di file dashboard.lua akan dihentikan (return langsung),
		-- dan dashboard tidak akan muncul sama sekali.
		-- tandain nih fungsi!
		if vim.fn.argc() > 0 then
			return
		end
		-- kalau ngga ngaruh, komenin aja lah sial!

		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local function centered_datetime()
			local time_str = os.date(" %A, %d %B %Y   %H:%M:%S")
			local display_width = vim.fn.strdisplaywidth(time_str)

			-- hitung panjang baris header terpanjang (contohnya 80)
			local max_width = 80 -- kamu bisa ganti dengan panjang baris header terpanjang

			local padding = math.floor((max_width - display_width) / 2)
			return string.rep(" ", padding) .. time_str
		end

		-- area seru-seruan bareng dashboard NVIM!! Minggir!

		-- dashboard.section.header.val = {
		--   "  ▄████▄   ▒█████   ██▀███   ▒█████   ██ ▄█▀",
		--   " ▒██▀ ▀█  ▒██▒  ██▒▓██ ▒ ██▒▒██▒  ██▒ ██▄█▒ ",
		--   " ▒▓█    ▄ ▒██░  ██▒▓██ ░▄█ ▒▒██░  ██▒▓███▄░ ",
		--   " ▒▓▓▄ ▄██▒▒██   ██░▒██▀▀█▄  ▒██   ██░▓██ █▄ ",
		--   " ▒ ▓███▀ ░░ ████▓▒░░██▓ ▒██▒░ ████▓▒░▒██▒ █▄",
		--   " ░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒▓ ░▒▓░░ ▒░▒░▒░ ▒ ▒▒ ▓▒",
		-- }

		-- dashboard.section.header.val = {
		--     "                                                 :b.                ",
		--     "            :h-                                  Nhy`               ",
		--     "           -mh.                           h.    `Ndho               ",
		--     "           hmh+                          oNm.   oNdhh               ",
		--     "          `Nmhd`                        /NNmd  /NNhhd               ",
		--     "          -NNhhy                      `hMNmmm`+NNdhhh               ",
		--     "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
		--     "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
		--     "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
		--     "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
		--     " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
		--     " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
		--     " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
		--     " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
		--     "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
		--     "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
		--     "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
		--     "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
		--     "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
		--     "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
		--     "       //+++//++++++////+++///::--                 .::::-------::   ",
		--     "       :/++++///////////++++//////.                -:/:----::../-   ",
		--     "       -/++++//++///+//////////////               .::::---:::-.+`   ",
		--     "       `////////////////////////////:.            --::-----...-/    ",
		--     "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
		--     "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
		--     "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
		--     "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
		--     "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
		--     "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
		--     "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
		--     "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
		--     "                        .-:mNdhh:.......--::::-`                    ",
		--     "                           yNh/..------..`                          ",
		--     "                                                                    ",
		-- }

		dashboard.section.header.val = {
			[[=================     ===============     ===============   ========  ========]],
			[[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
			[[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
			[[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
			[[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
			[[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
			[[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
			[[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
			[[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
			[[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
			[[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
			[[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
			[[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
			[[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
			[[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
			[[||.=='    _-'                                                     `' |  /==.||]],
			[[=='    _-'                                                            \/   `==]],
			[[\   _-'                      Code speaks, I listen                     `-_   /]],
			[[ `''                                                                      ``' ]],
			[[                                                                              ]],

			centered_datetime(),
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
			dashboard.button("o", "  Open Project Folder", function()
				projects.open()
			end),
			dashboard.button("g", "  Grep Text", ":Telescope live_grep<CR>"),
			dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("u", "  Update Plugins", ":Lazy update<CR>"),
			dashboard.button("l", "  Mason LSP", ":Mason<CR>"),
			dashboard.button("p", "  Plugin Manager", ":Lazy<CR>"),
			dashboard.button("s", "  Settings", ":e ~/.config/nvim/init.lua<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		dashboard.section.footer.val = "⚡ Neovim ready to go!"

		-- Center layout
		dashboard.opts.layout[1].val = 8 -- padding top, bisa ubah ke 4–6 kalau mau lebih rapat
		alpha.setup(dashboard.opts)

		-- Biar tidak bisa scroll kosong ke bawah
		-- MODIFIKASI BAGIAN INI:
		-- Autocmd untuk menutup jendela alpha saat buffer lain terbuka
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			callback = function()
				vim.opt_local.scrolloff = 0
				vim.opt_local.wrap = true
				vim.opt_local.modifiable = false

				-- Cek apakah ada lebih dari satu jendela terbuka
				-- atau apakah buffer aktif bukan lagi alpha (setelah memicu Telescope misalnya)
				if
					#vim.api.nvim_list_wins() > 1
					or vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype") ~= "alpha"
				then
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "alpha" then
							pcall(vim.api.nvim_win_close, win, true)
						end
					end
				end
			end,
			-- Penting: JANGAN pakai 'once = true' di sini agar selalu berfungsi
			-- biarkan defaultnya (false) atau set eksplisit ke false
			once = false,
		})
	end,
}
