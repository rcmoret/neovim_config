local utils = require("config.icons")
local icons = utils.icons

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local git_add = string.gsub(icons.git.add, "%s+", "")
local git_modified = string.gsub(icons.git.modified, "%s+", "")
local git_removed = string.gsub(icons.ui.lsp_error, "%s+", "")

require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", },
      {
        "diff",
        symbols = {
          added = git_add,
          modified = git_modified,
          removed = git_removed,
        },
        source = diff_source,
        -- color = { bg = "none" },
        diff_color = {
          added = { fg = "#99c794" },
          modified = { fg = "#3a86ff" },
          removed = { fg = "#ff006e" },
        },
      },
    },
    lualine_c = {
      { "filename", path = 1, file_status = true },
    },
    lualine_x = {
      { "diagnostics", sources = { "nvim_lsp" } },
      { "filetype" },
    },
    lualine_y = { "progress" },
    lualine_z = {
      { "location" },
      { "datetime", style = "%T" }
    }
  },
  options = {
    theme = "OceanicNext",
    icons_enabled = true,
  }
})
  -- sections = {
  --   lualine_b = { "diff", source = diff_source() },
  --   lualine_c = { "filename", { "LSP Progress", source = lsp_progress } }
  -- },
  -- },
  -- extensions = {
    -- "fugitive",
  -- }
