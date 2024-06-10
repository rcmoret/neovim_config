local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
local utils = require("config.icons")
local icons = utils.icons

require("mason").setup({
  ui = {
    border = "rounded"
  }
})

require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "rust_analyzer", "ruby_lsp", "rubocop", "tailwindcss" },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
  }
})

vim.keymap.set("n", "<Leader>lf", function() vim.lsp.buf.format() end, { desc = "[l]sp [f]ormat file" })
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to Definition (LSP)" })
vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { desc = "Go to References (LSP)" })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Quick Info" })
vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end, { desc = "[l]sp search for [s]ymbols" })
vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, { desc = "[l]sp [d]iagnostics" })
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, { desc = "Go to next diagnostic (LSP)" })
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, { desc = "Go to prev diagnostic (LSP)" })
vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "[l]sp code actions" })
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "[l]sp [i]nfo" })
vim.keymap.set("n", "<leader>ll", "<cmd>LspInfo<CR>", { desc = "[l]sp [l]ogs" })
vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "[l]sp [r]ename" })
vim.keymap.set("n", "<leader>lR", "<cmd>so ~/.config/nvim/after/plugin/lsp.lua<CR>", { desc = "[l]sp [R]eload" })

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

require("fidget").setup({
  notification = {
    window = {
      normal_hl = "Normal",
      winblend = 0,
      border = "rounded",
      relative = "win"
    }
  }
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "yellow", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "yellow", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { fg = "yellow", italic = true })
