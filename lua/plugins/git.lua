local function prompt_cmd(template, input_opts)
  return function()
    local answer = vim.fn.input(input_opts)
    vim.cmd(string.format(template, answer))
    vim.cmd.echon '""'
  end
end

return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = { "Git", "Gdiffsplit", "GBrowse", "Gwrite", "GMove", "GRename", "Gedit", "Gread" },
    keys = {
      { "<Leader>gb", "<cmd>Git blame<CR>", desc = "[g]it [b]lame" },
      { "<Leader>gd", "<cmd>Gdiffsplit<CR>", desc = "[g]it split [d]iff" },
      { "<Leader>go", "<cmd>GBrowse<CR>", desc = "[g]it [o]pen in browser" },
      { "<Leader>gw", "<cmd>Gwrite<CR>", desc = "[g]it [w]rite" },
      {
        "<Leader>gm",
        prompt_cmd("GMove %s", { prompt = "new path > ", completion = "dir" }),
        desc = "[g]it [m]ove",
      },
      {
        "<Leader>gr",
        prompt_cmd("GRename %s", { prompt = "new name > " }),
        desc = "[g]it [r]ename",
      },
      {
        "<Leader>gc",
        prompt_cmd("Gedit %s:%%", { prompt = "commit/ref > " }),
        desc = "[g]it [c]heckout file @",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<Leader>gB",
        function() require("gitsigns").toggle_current_line_blame() end,
        desc = "Toggle single line [B]lame",
      },
    },
    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },

  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<Leader>gts",
        function()
          local treename = vim.fn.input "tree >"
          require("git-worktree").switch_worktree(treename)
        end,
        desc = "[g]it work[t]ree [s]witch",
      },
    },
  },
}
