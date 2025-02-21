local light_red = "#f7768e"
vim.cmd.colorscheme("rusty-scheme")

local set_hl = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

local create_link = function(target, link_to)
  set_hl(target, { link = link_to })
end

-- set_hl("RedUnderline", { fg = light_red, underline = true })
-- create_link("rubyConditional", "RedUnderline")

-- keep these / don't change!
vim.api.nvim_set_hl(0, "@lsp.type.variable.ruby", { })
vim.api.nvim_set_hl(0, "@lsp.type.method.ruby", { })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.ruby", { })
vim.api.nvim_set_hl(0, "@lsp.type.class.ruby", { })
