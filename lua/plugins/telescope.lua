-- Loaded on first use. Keys are declared here rather than in config so lazy
-- can register the triggers without pulling telescope in at startup.

local function builtin(name, opts)
  return function() require("telescope.builtin")[name](opts) end
end

local function extension(ext, name)
  return function() require("telescope").extensions[ext][name]() end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "princejoogie/dir-telescope.nvim",
    "danielvolchek/tailiscope.nvim",
    "ThePrimeagen/git-worktree.nvim",
    "folke/noice.nvim",
  },
  cmd = "Telescope",
  keys = {
    { "<C-t>", builtin "git_files", desc = "Fuzzy Find Files (git)" },
    { "<C-g>", extension("live_grep_args", "live_grep_args"), desc = "[t]elescope [g]rep (with args)" },

    { "<Leader>/a", builtin "autocommands", desc = "[t]elescope search in [a]utocommands" },
    { "<Leader>/b", builtin "buffers", desc = "[t]elescope search in [b]uffers" },
    { "<Leader>/c", builtin "command_history", desc = "[t]elescope search [c]ommand history" },
    { "<Leader>/d", extension("dir", "live_grep"), desc = "[t]elescope search in [d]irectories" },
    { "<Leader>/f", builtin "find_files", desc = "[t]elescope search for [f]iles (all)" },
    { "<Leader>/g", extension("live_grep_args", "live_grep_args"), desc = "[t]elescope [g]rep (with args)" },
    { "<Leader>/h", builtin "help_tags", desc = "[t]elescope search [h]elp tags" },
    { "<Leader>/j", builtin "jumplist", desc = "[t]elescope search [j]umplist" },
    { "<Leader>/k", builtin "keymaps", desc = "[t]elescope search [k]ey maps" },
    { "<Leader>/l", builtin "highlights", desc = "[t]elescope search high[l]ights" },
    { "<Leader>/n", "<cmd>Noice telescope<CR>", desc = "[t]elescope search in [n]otifications" },
    { "<Leader>/o", builtin("live_grep", { grep_open_files = true }), desc = "[t]elescope grep in [o]pen buffers" },
    { "<Leader>/r", builtin "resume", desc = "[t]elescope [r]esume search" },
    { "<Leader>/t", "<cmd>Telescope tailiscope<CR>", desc = "[t]elescope [t]ailwind search" },
    { "<Leader>/w", builtin "grep_string", desc = "[t]elescope search for current [w]ord in working directory" },
    { "<Leader>/R", builtin "registers", desc = "[t]elescope [R]egisters" },
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    telescope.setup {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        mappings = {
          i = {
            ["<PageDown>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.preview_scrolling_up,
          },
          n = {
            ["<C-c>"] = "close",
            ["<PageDown>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.preview_scrolling_up,
          },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<C-x>"] = "delete_buffer",
            },
          },
        },
      },
    }

    telescope.load_extension "dir"
    telescope.load_extension "git_worktree"
    telescope.load_extension "live_grep_args"
    telescope.load_extension "tailiscope"
    telescope.load_extension "noice"
  end,
}
