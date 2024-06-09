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
    requires = { {'nvim-lua/plenary.nvim'} }
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
    end})

  use "tpope/vim-commentary"
  use "mileszs/ack.vim"
end)