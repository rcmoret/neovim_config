-- Filetypes that still format on demand with <Leader>lf, but are left alone
-- on :w.
local no_format_on_save = {
  javascript = true,
  markdown = true,
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      prettier = {
        prepend_args = { "--print-width", "80" },
      },
    },
    formatters_by_ft = {
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
    },
    format_on_save = function(bufnr)
      if no_format_on_save[vim.bo[bufnr].filetype] then return nil end

      -- Skip formatting for any project with a .no-format file at its root
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local bufdir = vim.fn.fnamemodify(bufname, ":h")
      local no_format = vim.fn.findfile(".no-format", bufdir .. ";")

      if no_format ~= "" then return nil end

      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
  },
}
