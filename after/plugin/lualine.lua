local icons = require("config.icons").icons

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
local branch_abbr = function()
  local short_branch = vim.fn.system("git branch --show-current | cut -d '/' -f3 | tr -cd '[:alnum:]._-'")
  return short_branch .. " " ..icons.git.conflict
end

require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { branch_abbr, },
      {
        "diff",
        symbols = {
          added = git_add,
          modified = git_modified,
          removed = git_removed,
        },
        source = diff_source,
        diff_color = {
          added = { fg = "#06d6a0" },
          modified = { fg = "#00ffff" },
          removed = { fg = "#e57d7d" },
        },
      },
    },
    lualine_c = {
      { "filename", path = 1, file_status = true },
    },
    lualine_x = {
      { "diagnostics" },
    },
    lualine_y = {
      { "filetype" },
    },
    lualine_z = {
      { line_number },
      { column_number },
      { "datetime", style = "%l:%M"  }
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1, file_status = true } },
    lualine_x = {},
    lualine_y = {
      { line_number },
      { column_number }
    },
    lualine_z = {}
  },
  options = {
    theme = "Nord",
    icons_enabled = true,
    component_separators = { left = "）", right = "｜" },
    section_separators = { left = icons.ui.powerline_round_left, right = icons.ui.powerline_round_right },
  }
})
