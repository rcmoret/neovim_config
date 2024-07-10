-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- PACKER
  use "wbthomason/packer.nvim"

  -- ACK
  use "mileszs/ack.vim"
  -- ALPHA
  use({
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end
  })
  -- BLULOCO
  use({
    "uloco/bluloco.nvim",
    requires = { { "rktjmp/lush.nvim" } },
  })
  -- DIR-TELESCOPE
  use({
    "princejoogie/dir-telescope.nvim",
    requires = { "nvim-telescope/telescope.nvim" }
  })
  -- GITSIGNS
  use "lewis6991/gitsigns.nvim"
  -- INDENT-BLANKLINE
  use "lukas-reineke/indent-blankline.nvim"
  -- LUALINE
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      { "nvim-tree/nvim-web-devicons", opt = true },
      { "lewis6991/gitsigns.nvim" }
    }
  })
  -- NEO-TREE
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  })
  -- NVIM-HIGHLIGHT-COLORS
  use "brenoprata10/nvim-highlight-colors"
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
  -- NVIM-TREESITTER
  use "nvim-treesitter/nvim-treesitter"
  -- NVIM-WEB-DEVICONS
  use "nvim-tree/nvim-web-devicons"
  -- TAILISCOPE
  use "danielvolchek/tailiscope.nvim"
  -- TELESCOPE
  use({
    "nvim-telescope/telescope.nvim", tag = "0.1.6",
    requires = {
      {"nvim-lua/plenary.nvim"},
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    }
  })
  -- TOKYONIGHT
  use "folke/tokyonight.nvim"
  -- UNDOTREE
  use "mbbill/undotree"
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
  -- VIM-UNIMPAIRED
  use "tpope/vim-unimpaired"
  -- WHICH-KEY
  use "folke/which-key.nvim"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "j-hui/fidget.nvim"
end)
