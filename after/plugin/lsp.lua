local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
local utils = require("config.icons")
local icons = utils.icons

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer', 'ruby_lsp', 'rubocop' },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "<Leader>lf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

vim.diagnostic.config({
  inlay_hint = {
    enable = true,
  },
  float = {
    border = "single",
    focusable = true,
    style = "minimal",
    source = true,
    header = "",
    prefix = "  ",
  },
  virtual_text = {
    prefix = icons.ui.lsp_warn,
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.ui.lsp_error,
      [vim.diagnostic.severity.WARN] = icons.ui.lsp_warn,
      [vim.diagnostic.severity.INFO] = icons.ui.lsp_info,
      [vim.diagnostic.severity.HINT] = icons.ui.lsp_hint,
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
})

lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      hint = {
        enable = true,
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "yellow", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "yellow", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { fg = "yellow", italic = true })
