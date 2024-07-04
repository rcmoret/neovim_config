local colors = require("config.rusty-scheme").colors
vim.cmd.colorscheme("bluloco")

local float_bg = "#0D0D2B"
vim.api.nvim_set_hl(0, "Normal", { bg = colors.darkest_blue, fg = colors.off_white })
-- vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.off_white })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = colors.float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = colors.float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.darkest_blue, fg = colors.gray })
vim.api.nvim_set_hl(0, "NvimFloat", { bg = colors.float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = colors.float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "FloatShadow", { bg = colors.float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = colors.float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.dark_gray })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = colors.float_bg, fg = colors.gray })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.api.nvim_set_hl(0, "Number", { fg = colors.dark_blue })
vim.api.nvim_set_hl(0, "String", { fg = colors.dark_blue })
vim.api.nvim_set_hl(0, "Comment", { fg = colors.dark_gray })
vim.api.nvim_set_hl(0, "Pmenu", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "PmenuSBar", { fg = colors.gray, bg = colors.gray })
vim.api.nvim_set_hl(0, "PmenuThumb", { fg = colors.dark_gray, bg = colors.dark_gray })

vim.api.nvim_set_hl(0, "DarkBlue", {  fg = colors.dark_blue })
vim.api.nvim_set_hl(0, "DarkBlueBold", {  fg = colors.dark_blue, bold = true })
vim.api.nvim_set_hl(0, "DarkGreen", {  fg = colors.dark_green  })
vim.api.nvim_set_hl(0, "DarkOrange", {  fg = colors.dark_orange })
vim.api.nvim_set_hl(0, "DarkOrangeUnderline", {  fg = colors.dark_orange, underline = true })
vim.api.nvim_set_hl(0, "DarkPurple", {  fg = colors.dark_purple })
vim.api.nvim_set_hl(0, "Gray", {  fg = colors.gray })
vim.api.nvim_set_hl(0, "LightBlue", {  fg = colors.light_blue })
vim.api.nvim_set_hl(0, "LightBlueItalic", {  fg = colors.light_blue, italic = true })
vim.api.nvim_set_hl(0, "LightGray", {  fg = colors.light_gray })
vim.api.nvim_set_hl(0, "LightGreenBold", {  bold = true, fg = colors.light_green })
vim.api.nvim_set_hl(0, "LightOrangeUnderline", {  fg = colors.light_orange, underline = true })
vim.api.nvim_set_hl(0, "LightRedItalic", { fg = colors.light_red, italic = true })
vim.api.nvim_set_hl(0, "LightRedUnderline", { fg = colors.light_red, underline = true })
vim.api.nvim_set_hl(0, "LightYellow", {  fg = colors.light_yellow })
vim.api.nvim_set_hl(0, "LightYellowItalic", {  fg = colors.light_yellow, italic = true })
vim.api.nvim_set_hl(0, "Orange", {  fg = colors.dark_orange })
vim.api.nvim_set_hl(0, "Pale", {  fg = colors.pale })
vim.api.nvim_set_hl(0, "PaleUnderline", {  fg = colors.pale, underline = true })
vim.api.nvim_set_hl(0, "Purple", {  fg = colors.purple })
vim.api.nvim_set_hl(0, "Yellow", {  fg = colors.yellow })

vim.api.nvim_set_hl(0, "@lsp.type.variable.ruby", { })
vim.api.nvim_set_hl(0, "@lsp.type.method.ruby", { })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.ruby", { })
-- vim.api.nvim_set_hl(0, "rubyKeyword", { fg = colors.yellow })
-- vim.api.nvim_set_hl(0, "rubyBlockParameter", { fg = colors.dark_orange })
-- vim.api.nvim_set_hl(0, "rubyBlockParameterList", { fg = colors.dark_orange })
-- vim.api.nvim_set_hl(0, "@lsp.typemod.method.declaration.ruby", { fg = colors.light_blue })
-- vim.api.nvim_set_hl(0, "@lsp.typemod.variable.default_library.ruby", { fg = colors.pale })
-- vim.api.nvim_set_hl(0, "@lsp.type.variable.ruby", { fg = colors.pale })

  -- hi link @lsp.type.parameter.ruby LightGray
vim.cmd( [[
  hi link rubyBoolean LightRedItalic
  hi link rubyClass LightOrangeUnderline
  hi link rubyModule LightOrangeUnderline
  hi link rubyConstant DarkGreen
  hi link @lsp.type.namespace DarkGreen
  hi link rubyInstanceVariable Purple
  hi link rubySymbol DarkPurple
  hi link rubyCurlyBlockDelimiter Normal
  hi link rubyConditional LightRedUnderline
  hi link rubyControl DarkOrange
  hi link rubyFunction LightBlue
  hi link rubyDefine DarkBlue
  hi link rubyException DarkOrangeUnderline
  hi link rubyInterpolation PaleUnderline
  hi link rubyInterpolationDelimiter Pale
  hi link rubyPseudoVariable Purple
  hi link rubyMacro LightBlueItalic
  hi link rubyString DarkBlue
  hi link rubyCallback LightYellowItalic
  hi link rubyValidation LightYellowItalic
  hi link rubyEntities LightYellowItalic
  hi link rubyEntity LightYellowItalic
  hi link rubyKeyword Yellow
  hi link rubyBlockParameter Orange
  hi link rubyBlockParameterList Orange


]])

-- vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.light_green, bg = colors.colors.float_bg })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg= colors.light_yellow, bg=colors.float_bg })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.dark_orange, bg = colors.float_bg })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.dark_green, bg = colors.float_bg })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.red, bg=colors.float_bg })
vim.api.nvim_set_hl(0, "Pmenu", { bg=colors.float_bg })
vim.cmd([[
    hi link MsgArea NormalFloat
    hi link NotifyERRORBody NormalFloat
    hi link NotifyERRORIcon NormalFloat
    hi link NotifyERRORTitle  NormalFloat

    hi link NotifyWARNBody NormalFloat
    hi link NotifyWARNIcon NormalFloat
    hi link NotifyWARNTitle NormalFloat

    hi link NotifyINFOBody NormalFloat
    hi link NotifyINFOIcon NormalFloat
    hi link NotifyINFOTitle NormalFloat

    hi link NotifyDEBUGBody NormalFloat
    hi link NotifyDEBUGIcon NormalFloat
    hi link NotifyDEBUGTitle  NormalFloat

    hi link NotifyTRACEBody NormalFloat
    hi link NotifyTRACEIcon NormalFloat
    hi link NotifyTRACETitle  NormalFloat

    hi link NotifyLogTime NormalFloat
    hi link NotifyLogTitle NormalFloat
    hi link CmpItemMenuDefault NormalFloat
    hi link CmpItemKindDefault NormalFloat
    hi link CmpItemKind NormalFloat
]])

vim.cmd([[ hi link NormalNC Normal ]])


vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.float_bg, fg = colors.pale })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = colors.float_bg, strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = colors.float_bg, bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = colors.float_bg, bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = colors.float_bg, italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = colors.float_bg })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = colors.float_bg })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = colors.float_bg })
