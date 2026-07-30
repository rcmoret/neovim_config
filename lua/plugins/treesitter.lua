-- NOTE: still pinned to the archived `master` branch, matching the pre-lazy
-- setup. Moving to `main` is a separate migration.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "embedded_template", "json", "svelte" },
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
