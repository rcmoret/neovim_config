local sources = require("dropbar.sources")
local configs = require('dropbar.configs')

local function get_hl_color(group, attr)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

-- from lualine theme
local bg_gray = "#3b4252"
local light_blue = "#51a0cf"

-- vim.cmd [[hi WinBar guisp=#665c54 gui=underline guibg=#3b4252 guifg=#51a0cf]]
vim.api.nvim_set_hl(0, "WinBar", { bg = bg_gray, fg = light_blue })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bg_gray, fg = light_blue })
vim.cmd [[hi WinBarNC guisp=#665c54 gui=underline guibg=#3b4252]]
vim.cmd [[hi WinBarFill guisp=#665c54 gui=underline guibg=#3b4252]]

-- require("dropbar").setup(
--   {
--     bar = {
--       sources = {
--         {
--           get_symbols = function(buf, win, cursor)
--             local symbols = sources.path.get_symbols(buf, win, cursor)
--             print(symbols)
--             for _, symbol in ipairs(symbols) do
--               -- get correct icon color
--               local icon_fg = get_hl_color(symbol.icon_hl, "fg#")
--               print(symbol.icon_hl)
--               symbol.icon_hl = "DropbarSymbol" .. symbol.icon_hl

--               local icon_string = ""
--               if icon_fg == "" then
--                 icon_string = "hi " .. symbol.icon_hl .. " guifg=" .. light_blue
--               else
--                 icon_string = "hi " .. symbol.icon_hl .. " guisp=" .. light_blue .. " guifg=" .. icon_fg
--                 -- icon_string = "hi " .. symbol.icon_hl .. " guisp=#665c54 gui=underline guibg=#313131 guifg=" .. icon_fg
--               end

--               vim.cmd(icon_string)
--             end
--             return symbols
--           end
--         }
--       }
--     }
--   }
-- )

vim.ui.select = require("dropbar.utils.menu").select

-- vim.api.nvim_set_hl(0, "DropBarIconUIIndicator", { fg = bg_gray, bg = "#bada55" })
-- vim.api.nvim_set_hl(0, "DropBarMenuSbar", { fg = bg_gray, bg = "#bada55" })
-- vim.api.nvim_set_hl(0, "DropBarPreview", { fg = bg_gray, bg = "#bada55" })
vim.api.nvim_set_hl(0, "DropBarIconCurrentContext", { bg = bg_gray })
-- vim.api.nvim_set_hl(0, "DropBarCurrentContext", { fg = bg_gray, bg = "#bada55" })
-- vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { fg = bg_gray, bg = "#bada55" })
