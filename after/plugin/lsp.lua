local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
local utils = require("config.icons")
local icons = utils.icons

require("mason").setup({
  ui = {
    border = "rounded"
  }
})

vim.g.tw_ruby_toggle = false

local tw_setup = function()
  if vim.g.tw_ruby_toggle then
    local tw_filetypes = {
      "html",
      "erb",
      "eruby",
      "ruby",
    }
    local tw_settings = {
      ["includeLanguages"] = {
        { ruby = "erb" },
        { eruby = "erb" }
      },
      ["experimental"] = { classRegex = { "\\bclass:\\s*[\"']([^\"']*)" } }
    }
    lspconfig.tailwindcss.setup({
      capabilities = lsp_capabilities,
      filetypes = tw_filetypes,
      settings = {
        tailwindCSS = tw_settings
      }
    })
  else
    local tw_filetypes = {
      "html",
      "erb",
      "eruby",
    }
    local tw_settings = {
      ["includeLanguages"] = {
        { eruby = "erb" }
      },
      ["experimental"] = { classRegex = { "\\bclass:\\s*[\"']([^\"']*)" } }
    }
    lspconfig.tailwindcss.setup({
      capabilities = lsp_capabilities,
      filetypes = tw_filetypes,
      settings = {
        tailwindCSS = tw_settings
      }
    })
  end
end

require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "rust_analyzer", "ruby_lsp", "rubocop", "tailwindcss" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
    ["tailwindcss"] = tw_setup
  }
})

local tw_ruby_toggle_fn = function()
  vim.g.tw_ruby_toggle = not(vim.g.tw_ruby_toggle)
  tw_setup()
end

require("lspconfig.ui.windows").default_options.border = "rounded"

require("which-key").register({ l = { name = "[l]sp commands" } }, { prefix = "<Leader>" })

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "[g]o to [d]efinition (LSP)" })
vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { desc = "[g]o to References (LSP)" })
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, { desc = "go to next [d]iagnostic (LSP)" })
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, { desc = "go to prev [d]iagnostic (LSP)" })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "quick info" })
vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "[l]sp code [a]ctions" })
vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, { desc = "[l]sp [d]iagnostics" })
vim.keymap.set("n", "<Leader>lf", function() vim.lsp.buf.format() end, { desc = "[l]sp [f]ormat file" })
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "[l]sp [i]nfo" })
vim.keymap.set("n", "<leader>ll", "<cmd>LspInfo<CR>", { desc = "[l]sp [l]ogs" })
vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "[l]sp [r]ename" })
vim.keymap.set("n", "<leader>lR", "<cmd>so ~/.config/nvim/after/plugin/lsp.lua<CR>", { desc = "[l]sp [R]eload" })
vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end, { desc = "[l]sp search for [s]ymbols" })
vim.keymap.set("n", "<leader>lt", tw_ruby_toggle_fn, { desc = "[l]sp toggle [t]w lsp on ruby files" })

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
      normal_hl = "NormalFloat",
      winblend = 0,
      border = "rounded",
      relative = "win"
    }
  }
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "yellow", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "yellow", italic = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { fg = "yellow", italic = true })
