-- Small, config-free plugins: mostly tpope, plus a few language/navigation
-- helpers that only need to be present.

return {
  {
    "tpope/vim-commentary",
    keys = {
      { "gc", mode = { "n", "x", "o" } },
      { "gcc", mode = "n" },
    },
  },

  {
    "tpope/vim-surround",
    keys = {
      { "cs", mode = "n" },
      { "ds", mode = "n" },
      { "ys", mode = "n" },
      { "S", mode = "x" },
    },
  },

  {
    "tpope/vim-abolish",
    cmd = { "Abolish", "Subvert" },
    keys = { { "cr", mode = "n", desc = "coerce case (abolish)" } },
  },

  -- these register autocmds / operator mappings broadly enough that a key
  -- trigger would be more fragile than it is worth
  { "tpope/vim-unimpaired", event = "VeryLazy" },
  { "jeffkreeftmeijer/vim-numbertoggle", event = "VeryLazy" },

  -- endwise builds its <CR> mapping on VimEnter and its per-language rules on
  -- FileType, so any lazy trigger sources it after both have already fired and
  -- it silently stops inserting `end`. It is ~150 lines of vimscript; eager.
  { "tpope/vim-endwise", lazy = false },
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
  { "vim-crystal/vim-crystal", ft = "crystal" },
  { "mileszs/ack.vim", cmd = { "Ack", "AckAdd" } },
  { "mfussenegger/nvim-dap", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
      { "<Leader>u", "<cmd>UndotreeToggle<CR>", desc = "[u]ndotree toggle helper" },
    },
  },

  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>", desc = "tmux navigate left" },
      { "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>", desc = "tmux navigate down" },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>", desc = "tmux navigate up" },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>", desc = "tmux navigate right" },
      { "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<CR>", desc = "tmux navigate last active" },
    },
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
