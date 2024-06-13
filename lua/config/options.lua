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

local function delayed_start_up_func()
    local timer = vim.loop.new_timer()
    local function callback()
      vim.cmd.set([[winfixbuf]])
      -- vim.cmd([[set winfixbuf ]])
    end
    -- Delay 2000ms and 0 means "do not repeat"
    timer:start(2000, 0, vim.schedule_wrap(callback))
end
delayed_start_up_func()

vim.api.nvim_create_autocmd(
  { "FocusGained", "BufEnter", "CursorHold" },
  {
    callback = function()
      vim.api.nvim_command("checktime")
    end
  }
)
