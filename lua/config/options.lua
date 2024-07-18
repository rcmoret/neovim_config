vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.ignorecase = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.mouse = ""
vim.opt.iskeyword:append({"-", "@"})
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.timeout = true
vim.opt.timeoutlen = 1200

vim.opt.history = 10000
vim.opt.background = "dark"
vim.opt.list = true
vim.opt.listchars = {
  tab = "> ",
  space = " ",
  trail = "·",
}

local light_switch = require("plugin.light_switch")

-- #832913

light_switch.register({
  code = "rel",
  desc = "Relative line numbers",
  default = "on",
  enable = function()
    vim.cmd([[windo set relativenumber]])
    vim.cmd([[tabdo set relativenumber]])
  end,
  disable = function()
    vim.cmd([[windo set norelativenumber]])
    vim.cmd([[tabdo set norelativenumber]])
  end
})

light_switch.register({
  code = "wr",
  desc = "Line wrap",
  default = "off",
  enable = function()
    vim.opt.wrap = true
  end,
  disable = function()
    vim.opt.wrap = false
  end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("Quick Fix Override", { clear = false }),
  desc = "allow customization of the quickfix window",
  pattern = "quickfix",
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd(
  { "TextYankPost" },
  {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("Highlight-yank", { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  }
)

vim.api.nvim_create_autocmd(
  { "FocusGained", "BufEnter", "CursorHold" },
  {
    callback = function()
      vim.api.nvim_command("checktime")
    end
  }
)
