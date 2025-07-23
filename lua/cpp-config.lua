-- lua/cpp.lua

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		local is_windows = vim.loop.os_uname().version:match("Windows")
		local exe_ext = is_windows and ".exe" or ""
		local run_cmd = is_windows and "%<" or "./%<"

		-- tombol F3 untuk run saja dari input.txt dan output.txt:
		vim.keymap.set("n", "<F3>", function()
			local filename = vim.fn.expand("%:t:r")
			local current_dir = vim.fn.expand("%:p:h")
			local exe_file = filename .. ".exe"
			local exe_path = current_dir .. "/" .. exe_file
			local input_path = current_dir .. "/input.txt"

			-- Cek apakah file executable sudah ada
			if vim.fn.filereadable(exe_path) == 0 then
				vim.notify("❌ File executable belum ada! Tekan <F4> dulu untuk kompilasi.", vim.log.levels.ERROR)
				return
			end

			-- Cek apakah input.txt tersedia
			if vim.fn.filereadable(input_path) == 0 then
				vim.notify("⚠️ input.txt tidak ditemukan!", vim.log.levels.WARN)
				return
			end

			-- Jalankan executable dengan input/output redirection
			local cmd = string.format('cd /D "%s" && "%s" < input.txt > output.txt', current_dir, exe_file)

			vim.fn.jobstart({ "cmd.exe", "/C", cmd }, {
				stdout_buffered = true,
				stderr_buffered = true,
				on_exit = function(job_id, code, _)
					if code ~= 0 then
						vim.notify("❌ Gagal Menjalankan File!", vim.log.levels.ERROR, { title = "Run Error" })
						return
					end

					vim.notify("🚀 Program berhasil dijalankan (tanpa compile ulang).", vim.log.levels.INFO)

					-- Refresh output.txt kalau sedang dibuka
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						local name = vim.api.nvim_buf_get_name(buf)
						if name:match("output%.txt$") then
							vim.api.nvim_buf_call(buf, function()
								vim.cmd("checktime")
							end)
						end
					end
				end,
			})
		end, { buffer = true, noremap = true, silent = true })

		--  tombol F4 untuk compile + run dari input.txt dan output.txt
		vim.keymap.set("n", "<F4>", function()
			vim.cmd("w") -- simpan file dulu

			local filename = vim.fn.expand("%:t:r")
			local filepath = vim.fn.expand("%:p")
			local exe_file = filename .. ".exe"

			-- Pastikan input.txt dan output.txt berada di direktori yang sama dengan file sumber
			-- Ini penting agar cmd.exe bisa menemukannya dengan path relatif
			local current_dir = vim.fn.fnamemodify(filepath, ":h")

			-- Gabungkan compile dan run dalam satu perintah cmd.exe
			-- Perintah akan dijalankan dari direktori file saat ini
			local cmd = string.format(
				'cd /D "%s" && g++ "%s" -o "%s" && "%s" < input.txt > output.txt',
				current_dir,
				filepath,
				exe_file,
				exe_file
			)

			vim.fn.jobstart({ "cmd.exe", "/C", cmd }, {
				stdout_buffered = true,
				stderr_buffered = true,
				on_exit = function(job_id, code, event)
					if code ~= 0 then
						-- Jika ada error, ambil dan tampilkan output stderr
						local stderr_output = vim.fn.jobget(job_id, "stderr")
						local error_message = "❌ Compile atau Run gagal!\n"
						if #stderr_output > 0 then
							error_message = error_message .. table.concat(stderr_output, "\n")
						else
							error_message = error_message .. "Tidak ada detail error yang tersedia."
						end
						vim.notify(error_message, vim.log.levels.ERROR, { title = "Build Error" })
						return
					end

					-- Jika berhasil, notifikasi sukses
					vim.notify("✅ Kompilasi dan Eksekusi Berhasil!", vim.log.levels.INFO)

					-- Refresh output.txt kalau sedang dibuka
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						local name = vim.api.nvim_buf_get_name(buf)
						if name:match("output%.txt$") then
							vim.api.nvim_buf_call(buf, function()
								vim.cmd("checktime")
							end)
						end
					end
				end,
			})
		end, { buffer = true, noremap = true, silent = true })

		-- vim.api.nvim_create_autocmd("BufEnter", {
		--   pattern = "output.txt",
		--   command = "checktime"
		-- })

		-- F5: Compile + Run
		vim.keymap.set("n", "<F5>", function()
			vim.cmd("w")
			local is_windows = vim.loop.os_uname().version:match("Windows")
			local exe_ext = is_windows and ".exe" or ""
			local run_cmd = (is_windows and ".\\" or "./") .. vim.fn.expand("%:t:r") .. exe_ext
			vim.cmd("belowright split | terminal g++ % -o %<" .. exe_ext .. " && " .. run_cmd)
		end, { buffer = true, noremap = true, silent = true })

		-- F6: Run only
		vim.keymap.set("n", "<F6>", function()
			local is_windows = vim.loop.os_uname().version:match("Windows")
			local exe_ext = is_windows and ".exe" or ""
			local run_cmd = (is_windows and ".\\" or "./") .. vim.fn.expand("%:t:r") .. exe_ext
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
