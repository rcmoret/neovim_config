-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use({
    "uloco/bluloco.nvim",
    requires = { { "rktjmp/lush.nvim" } },
 })

  use({
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = {
      {'nvim-lua/plenary.nvim'},
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    }
  })

  -- use "alexghergh/nvim-tmux-navigation"
  use({
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require"nvim-tmux-navigation".setup {
          disable_when_zoomed = true, -- defaults to false
          keybindings = {
              left = "<C-h>",
              down = "<C-j>",
              up = "<C-k>",
              right = "<C-l>",
              last_active = "<C-\\>",
              next = "<C-Space>",
          }
      }
    end
  })

use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  use "nvim-treesitter/nvim-treesitter"

  use "rafamadriz/friendly-snippets"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
 }

  use "mfussenegger/nvim-lint"
  use "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim"
  use "honza/vim-snippets"

  use "akinsho/flutter-tools.nvim"
  use "lvimuser/lsp-inlayhints.nvim"
  use "mfussenegger/nvim-dap"
  use "scalameta/nvim-metals"

  use "tpope/vim-commentary"
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"
  use "tpope/vim-rails"
  use "tpope/vim-surround"
  use "tpope/vim-abolish"
  use "tpope/vim-endwise"
  use "tpope/vim-unimpaired"
  use "tpope/vim-sexp-mappings-for-regular-people"
  use "lukas-reineke/indent-blankline.nvim"
  use "lewis6991/gitsigns.nvim"
  use "mileszs/ack.vim"
  use "mbbill/undotree"
  use "folke/which-key.nvim"
  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      { "nvim-tree/nvim-web-devicons", opt = true },
      { "lewis6991/gitsigns.nvim" }
    }
  }
  use {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end
  }
  use "j-hui/fidget.nvim"
end)
