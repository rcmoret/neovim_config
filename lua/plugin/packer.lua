-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- PACKER
  use "wbthomason/packer.nvim"

  -- ACK
  use "mileszs/ack.vim"
  -- BLULOCO
  use({
    "uloco/bluloco.nvim",
    requires = { { "rktjmp/lush.nvim" } },
  })
  -- NVIM-TMUX-NAVIGATION
  use({
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
        }
      }
    end
  })
  -- VIM-COMMENTARY
  use "tpope/vim-commentary"
  -- WHICH-KEY
  use "folke/which-key.nvim"
end)
