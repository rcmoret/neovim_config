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
local line_number = function()
  return "Ln: " .. vim.fn.line('.')
end
local column_number = function()
  return "Col: " .. vim.fn.virtcol('.')
end

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
    lualine_x = { { "diagnostics" } },
    lualine_y = {
      { "filetype" },
    },
    lualine_z = {
      { line_number },
      { column_number }
    },
  },
  winbar = {
    lualine_a = {},
    lualine_b = {
      { "filename", file_status = true, use_mode_colors = false },
    },
    lualine_c = {
      { current_signature }
    },
    lualine_y = { { "datetime", style = "%b %d, %Y %r" } },
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {
      { "filename", file_status = true },
    },
  },
  options = {
    theme = "OceanicNext",
    icons_enabled = true,
    component_separators = { left = "｜", right = "｜" },
    section_separators = { left = icons.ui.powerline_round_left, right = icons.ui.powerline_round_right },
  }
})
