-- lazy.nvim bootstrap. Plugin specs are imported from lua/plugins/.

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = { { import = "plugins" } },
  install = { colorscheme = { "rusty-scheme" } },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
}

vim.keymap.set("n", "<Leader>kk", "<cmd>Lazy<CR>", { desc = "la[z]y home" })
vim.keymap.set("n", "<Leader>kc", "<cmd>Lazy clean<CR>", { desc = "lazy pkgs [c]lean" })
vim.keymap.set("n", "<Leader>ki", "<cmd>Lazy install<CR>", { desc = "lazy pkgs [i]nstall" })
vim.keymap.set("n", "<Leader>ks", "<cmd>Lazy sync<CR>", { desc = "lazy pkgs [s]ync" })
vim.keymap.set("n", "<Leader>kS", "<cmd>Lazy check<CR>", { desc = "lazy pkgs [S]tatus" })
vim.keymap.set("n", "<Leader>ku", "<cmd>Lazy update<CR>", { desc = "lazy pkgs [u]pdate" })
