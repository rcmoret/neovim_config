-- Small, config-free plugins: mostly tpope, plus a few language/navigation
-- helpers that only need to be present.

return {
  { "tpope/vim-abolish",    event = "VeryLazy" },
  { "tpope/vim-commentary", event = "VeryLazy" },
  { "tpope/vim-endwise",    event = "InsertEnter" },
  { "tpope/vim-surround",   event = "VeryLazy" },
  { "tpope/vim-unimpaired", event = "VeryLazy" },
  { "tpope/vim-rails",      ft = { "ruby", "eruby" } },

  { "vim-crystal/vim-crystal",              ft = "crystal" },
  { "jeffkreeftmeijer/vim-numbertoggle",    event = "VeryLazy" },
  { "mileszs/ack.vim",                      cmd = { "Ack", "AckAdd" } },
  { "mfussenegger/nvim-dap",                lazy = true },
  { "nvim-tree/nvim-web-devicons",          lazy = true },

  {
    "mbbill/undotree",
    keys = {
      { "<Leader>u", vim.cmd.UndotreeToggle, desc = "[u]ndotree toggle helper" },
    },
  },

  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
      },
    },
  },
}
