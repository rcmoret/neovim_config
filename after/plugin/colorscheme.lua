local function is_dark_mode()
  local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
  return vim.trim(result) == "Dark"
end

local function apply_colorscheme()
  if is_dark_mode() then
    vim.cmd.colorscheme "rusty-scheme"
  else
    vim.cmd.colorscheme "rusty-scheme-light"
    -- vim.api.nvim_set_hl(0, "Cursor", { bg = "#333333" })
    -- vim.api.nvim_set_hl(0, "TermCursor", { bg = "#333333" })
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "Cursor", { bg = "#CC4400", fg = "#F9F5EE" })
      vim.api.nvim_set_hl(0, "TermCursor", { bg = "#CC4400", fg = "#F9F5EE" })
    end)
  end
end

apply_colorscheme()

-- Poll every 5 seconds for macOS appearance changes
local timer = vim.uv.new_timer()
local last_dark = is_dark_mode()
timer:start(5000, 5000, vim.schedule_wrap(function()
  local dark = is_dark_mode()
  if dark ~= last_dark then
    last_dark = dark
    apply_colorscheme()
  end
end))

local set_hl = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end

local create_link = function(target, link_to) set_hl(target, { link = link_to }) end

-- set_hl("RedUnderline", { fg = light_red, underline = true })
-- create_link("rubyConditional", "RedUnderline")

-- keep these / don't change!
vim.api.nvim_set_hl(0, "@lsp.type.variable.ruby", {})
vim.api.nvim_set_hl(0, "@lsp.type.method.ruby", {})
vim.api.nvim_set_hl(0, "@lsp.type.parameter.ruby", {})
vim.api.nvim_set_hl(0, "@lsp.type.class.ruby", {})
