vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
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

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.history = 10000
vim.opt.background = "dark"
vim.opt.list = true
vim.opt.listchars = {
  tab = "> ",
  space = " ",
  trail = "·",
}
vim.opt.iskeyword:append({"-", "@"})

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
