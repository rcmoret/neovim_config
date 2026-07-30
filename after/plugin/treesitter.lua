require("nvim-treesitter").setup({
  ensure_installed = { "tree-sitter-embedded-template", "json", "svelte" },
  indent = {
    enabled = true
  },
  highlight = {
    enabled = true,
    additional_vim_regex_highlighting = false,
  },
})
