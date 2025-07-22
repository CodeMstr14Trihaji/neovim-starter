-- -- lua/core/projects.lua





-- [ MODE 1 : Satu tab terminal = multi project]


-- local M = {}

-- -- Daftar path ke folder project kamu
-- M.paths = {
--   { name = "Competitive Programming", path = "D:/Github/Competitive-programming" },
--   { name = "Codeforces Contest", path = "D:/Github/Competitive-programming/CodeForce-Contest" },
--   { name = "Nvim Config", path = "C:/Users/ASUS/AppData/Local/nvim" },
-- }

-- -- Fungsi untuk memilih dan membuka project pakai Telescope
-- M.open = function()
--   local pickers = require("telescope.pickers")
--   local finders = require("telescope.finders")
--   local actions = require("telescope.actions")
--   local action_state = require("telescope.actions.state")
--   local conf = require("telescope.config").values

--   pickers.new({}, {
--     prompt_title = "Open Project",
--     finder = finders.new_table {
--       results = M.paths,
--       entry_maker = function(entry)
--         return {
--           value = entry,
--           display = entry.name,
--           ordinal = entry.name
--         }
--       end,
--     },
--     sorter = conf.generic_sorter({}),
--     attach_mappings = function(prompt_bufnr, map)
--       actions.select_default:replace(function()
--         actions.close(prompt_bufnr)
--         local selection = action_state.get_selected_entry()
        
--         -- --- Perubahan di sini: Buka di tab baru ---
--         vim.cmd("tabnew") -- Buka tab baru
--         vim.api.nvim_set_current_dir(selection.value.path) -- Ganti working directory di tab baru
--         vim.cmd("e .") -- Buka buffer kosong di direktori baru (ini sering memicu file explorer)

--         -- Buka NvimTree di tab baru ini
--         if pcall(require, "nvim-tree.api") then
--             require("nvim-tree.api").tree.open()
--         else
--             vim.notify("NvimTree is not installed or configured correctly.", vim.log.levels.WARN)
--         end
--         -- --- Akhir perubahan ---

--       end)
--       return true
--     end,
--   }):find()
-- end

-- return M













-- [ MODE 2 | tab terminal = satu project]

-- lua/core/projects.lua

local M = {}

-- Daftar path ke folder project kamu
M.paths = {
  { name = "Competitive Programming", path = "D:/Github/Competitive-programming" },
  { name = "Codeforces Contest", path = "D:/Github/Competitive-programming/CodeForce-Contest" },
  { name = "Nvim Config", path = "C:/Users/ASUS/AppData/Local/nvim" },
}

-- Fungsi untuk memilih dan membuka project pakai Telescope
M.open = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values

  pickers.new({}, {
    prompt_title = "Open Project",
    finder = finders.new_table {
      results = M.paths,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        -- Ambil ID tab saat ini (tab Alpha)
        local current_tab = vim.api.nvim_get_current_tabpage()

        -- Tutup semua jendela Alpha yang ada
        -- Kita iterate semua jendela di semua tab untuk memastikan
        for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
            for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(tab_id)) do
                local buf_id = vim.api.nvim_win_get_buf(win_id)
                if vim.bo[buf_id].filetype == "alpha" then
                    -- Hapus buffer alpha, ini lebih efektif daripada hanya menutup jendela
                    -- Jangan force delete jika buffer itu sedang aktif di jendela yang akan kita pakai
                    if win_id == vim.api.nvim_get_current_win() and #vim.api.nvim_list_tabpages() == 1 then
                        -- Jika Alpha adalah satu-satunya tab dan satu-satunya jendela,
                        -- biarkan dia, nanti akan ditimpa oleh NvimTree/buffer baru
                    else
                        pcall(vim.api.nvim_win_close, win_id, true)
                        pcall(vim.api.nvim_buf_delete, buf_id, { force = true, unload = true })
                    end
                end
            end
        end

        -- Tutup tab yang berisi Alpha (tab saat ini) jika ada tab lain
        if #vim.api.nvim_list_tabpages() > 1 and current_tab == vim.api.nvim_get_current_tabpage() then
            -- Pastikan kita hanya menutup tab yang berisi Alpha (jika masih aktif)
            -- dan ada tab lain yang bisa menjadi fokus.
            vim.cmd("tabclose")
        end

        -- Ganti working directory di tab baru/saat ini
        vim.api.nvim_set_current_dir(selection.value.path)

        -- Buka NvimTree atau buffer kosong.
        -- Ini akan menimpa buffer Alpha jika Alpha adalah satu-satunya buffer di tab yang tidak ditutup.
        if pcall(require, "nvim-tree.api") then
            require("nvim-tree.api").tree.open()
        else
            vim.notify("NvimTree is not installed or configured correctly. Opening empty buffer.", vim.log.levels.WARN)
            vim.cmd("e .") -- Buka buffer kosong
        end

        -- Pembersihan buffer Alpha secara global jika masih ada yang tersisa
        for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf_id) and vim.bo[buf_id].filetype == "alpha" then
                pcall(vim.api.nvim_buf_delete, buf_id, { force = true, unload = true })
            end
        end

      end)
      return true
    end,
  }):find()
end

return M