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
        
        -- --- Perubahan di sini: Buka di tab baru ---
        vim.cmd("tabnew") -- Buka tab baru
        vim.api.nvim_set_current_dir(selection.value.path) -- Ganti working directory di tab baru
        vim.cmd("e .") -- Buka buffer kosong di direktori baru (ini sering memicu file explorer)

        -- Buka NvimTree di tab baru ini
        if pcall(require, "nvim-tree.api") then
            require("nvim-tree.api").tree.open()
        else
            vim.notify("NvimTree is not installed or configured correctly.", vim.log.levels.WARN)
        end
        -- --- Akhir perubahan ---

      end)
      return true
    end,
  }):find()
end

return M