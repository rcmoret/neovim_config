-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  -- opts = function(_, opts)
  --   opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
  --     "lua",
  --     "vim",
  --     -- add more arguments for adding more treesitter parsers
  --   })
  -- end,
  opts = {
    indent = {
      enable = true,
      disable = { "ruby" },
    },
    aliases = {
      ["eruby"] = "html",
    },
    auto_install = true,
    "vim",
    "go",
    "toml",
    "css",
    "tsx",
    "css",
    "html",
  },
  autotag = {
    enable = true,
    rename = true,
    filetypes = {
      "erb",
      "html",
      "eruby",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "css",
      "lua",
      "xml",
      "php",
      "markdown",
    },
  },
}
