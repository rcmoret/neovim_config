-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- PACKER
  use "wbthomason/packer.nvim"

  -- WHICH-KEY
  use "folke/which-key.nvim"
end)
