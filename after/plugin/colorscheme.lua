vim.cmd.colorscheme("bluloco")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#adb5bd" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffd60a", bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })


-- Ruby
local burnt_orange = "#f48c06"
local dark_blue = "#3a86ff"
local light_green = "#06d6a0"
local gray = "#adb5bd"
local light_blue = "#00ffff"
local purple = "#a081fe" --"#C87DE9"
local red = "#ff006e"
-- local light_red = "#DAB6CA"
local light_red = "#E57D7D" -- "#FF33FF"
-- local light_red = "#e97eaf"
local yellow = "#ffd60a"

-- vim.api.nvim_set_hl(0, "Identifier", { fg = gray })
vim.api.nvim_set_hl(0, "rubyAttribute", { fg = light_blue, underline = true })
vim.api.nvim_set_hl(0, "rubyBoolean", { fg = red, italic = true })
vim.api.nvim_set_hl(0, "rubyClass", { fg = burnt_orange, underline = true })
vim.api.nvim_set_hl(0, "rubyConstant", { fg = light_green, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = light_green, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = light_green, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.method.ruby", { fg = "#BABAB7" })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.ruby", { fg = "#BABAB7" })
vim.api.nvim_set_hl(0, "rubyConditional", { fg = light_red, underline = true })
vim.api.nvim_set_hl(0, "rubyControl", { fg = light_green })
vim.api.nvim_set_hl(0, "Function", { fg = light_green })
vim.api.nvim_set_hl(0, "rubyDefine", { fg = dark_blue, bold = true })
vim.api.nvim_set_hl(0, "rubyException", { fg = burnt_orange, underline = true })
vim.api.nvim_set_hl(0, "rubyHelper", { fg = dark_blue, bold = true })
vim.api.nvim_set_hl(0, "rubyInstanceVariable", { fg = purple })
vim.api.nvim_set_hl(0, "rubyInterpolation", { fg = light_blue })
vim.api.nvim_set_hl(0, "rubyInterpolationDelimiter", { fg = purple })
vim.api.nvim_set_hl(0, "rubyPseudoVariable", { fg = purple })
vim.api.nvim_set_hl(0, "rubyMacro", { fg = purple })
vim.api.nvim_set_hl(0, "rubyKeywordAsMethod", { fg = purple })
vim.api.nvim_set_hl(0, "rubyModule", { fg = burnt_orange, underline = true })
vim.api.nvim_set_hl(0, "Number", { fg = dark_blue })
vim.api.nvim_set_hl(0, "rubyString", { fg = dark_blue })
vim.api.nvim_set_hl(0, "rubyStringDelimiter", { fg = dark_blue })
vim.api.nvim_set_hl(0, "rubyKeyword", { fg = yellow })
vim.api.nvim_set_hl(0, "rubySymbol", { fg = light_blue })
vim.api.nvim_set_hl(0, "Normal", { fg = "#BABAB7" })
vim.api.nvim_set_hl(0, "rubyBlockParameter", { fg = burnt_orange })
vim.api.nvim_set_hl(0, "rubyBlockParameterList", { fg = burnt_orange })
vim.api.nvim_set_hl(0, "rubyCurlyBlockDelimiter", { fg = "#BABAB7" })
vim.api.nvim_set_hl(0, "@lsp.typemod.method.declaration.ruby", { fg = light_green })
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.default_library.ruby", { fg = "#BABAB7" })
vim.api.nvim_set_hl(0, "@lsp.type.variable.ruby", { fg = "#BABAB7" })
-- vim.api.nvim_set_hl(0, "@lsp.mod.declaration.ruby", { fg = light_green })
-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#777777" })
vim.cmd([[match TrailingWhitespace /\s\+$/]])
vim.api.nvim_set_hl(0, "TrailingWhitespace", { fg = "#ffd60a", bg = "#4a4e69" })


vim.fn.matchadd("RubyMacros", "^\\s\\+delegate\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+devise\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+accepts_nested_attributes_for\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+belongs_to\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+has_\\(many\\|one\\)\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+renders_\\(many\\|one\\)\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+scope\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+enum\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+monetize\\(_subcents\\)\\?\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+unitize\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+validates\\?\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+encrypts\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+store_accessor\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+after_state\\s")
vim.fn.matchadd("RubyMacros", "^\\s\\+\\(before\\|after\\|around\\)_\\(action\\|save\\|commit\\|initialize\\|validation\\|destroy\\|commmit\\|update\\|create\\)\\(_state\\)\\?\\s")
-- vim.fn.matchadd("RubyBlockParameters", "|\\(*\\?\\w\\+\\(, \\)\\?\\)\\+|")
-- vim.fn.matchadd("RubyBlockParameters", "&block")
-- vim.fn.matchadd("RubyBlockParameters", "&:\\?\\w\\+\\(!\\|?\\)\\?")

vim.api.nvim_create_autocmd(
  { "BufAdd", "BufEnter", "BufWinEnter", "TabEnter", "WinEnter", "BufRead", "BufReadPre", "BufReadPost", "BufNewFile", "WinNew" },
  {
    callback = function()
      if (vim.bo.filetype == "ruby") then
        vim.api.nvim_set_hl(0, "RubyMacros", { fg = purple })
        -- vim.api.nvim_set_hl(0, "RubyBlockParameters", { fg = burnt_orange })
      end
    end
  }
)

-- for _, group in ipairs(vim.fn.getcompletion("@lsp.type", "highlight")) do
--   vim.api.nvim_set_hl(0, group, {})
-- end
