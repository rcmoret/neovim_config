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
  -- NVIM-WEB-DEVICONS
  use "nvim-tree/nvim-web-devicons"
  -- VIM-ABOLISH
  use "tpope/vim-abolish"
  -- VIM-COMMENTARY
  use "tpope/vim-commentary"
  -- VIM-ENDWISE
  use "tpope/vim-endwise"
  -- VIM-FUGITIVE
  use "tpope/vim-fugitive"
  -- VIM-RAILS
  use "tpope/vim-rails"
  -- VIM-RHUBARB
  use "tpope/vim-rhubarb"
  -- VIM-SURROUND
  use "tpope/vim-surround"
  -- WHICH-KEY
  use "folke/which-key.nvim"
end)
