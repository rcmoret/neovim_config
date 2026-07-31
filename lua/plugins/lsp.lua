-- Uses the Neovim 0.11+ vim.lsp.config API. Servers are expected on $PATH
-- (ruby-lsp comes from mise; the rest from npm/rustup/brew).

return {
  "neovim/nvim-lspconfig",
  -- conform is deliberately not a dependency: the <Leader>lf keymap requires
  -- it on demand, and lazy loads it from that require.
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "j-hui/fidget.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    local light_switch = require("lib.light_switch")
    local icons = require("theme.icons")

    vim.lsp.config("*", {
      capabilities = lsp_capabilities,
      ui = { border = "rounded" },
    })

    vim.lsp.config.ruby_lsp = {
      cmd = { vim.fn.expand("~/.local/bin/mise"), "exec", "--", "ruby-lsp" },
      filetypes = { "ruby", "eruby" },
      root_markers = { "Gemfile", ".git" },
      init_options = {
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false,
          },
        },
      },
    }

    vim.lsp.config.ts_ls = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    }

    vim.lsp.config.rust_analyzer = {
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      root_markers = { "Cargo.toml", ".git" },
    }

    local tw_setup = function()
      local tw_filetypes = {
        "html",
        "erb",
        "eruby",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      }
      local tw_include = { eruby = "erb" }
      if light_switch.is_enabled "twr" then
        table.insert(tw_filetypes, "ruby")
        tw_include.ruby = "erb"
      end
      vim.lsp.config.tailwindcss = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = tw_filetypes,
        root_markers = {
          "tailwind.config.js",
          "tailwind.config.ts",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "package.json",
          ".git",
        },
        settings = {
          tailwindCSS = {
            includeLanguages = tw_include,
            experimental = { classRegex = { "\\bclass:\\s*[\"']([^\"']*)" } },
          },
        },
      }
    end
    tw_setup()

    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
      },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          hint = { enable = true },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }

    vim.lsp.enable { "ruby_lsp", "ts_ls", "rust_analyzer", "tailwindcss", "lua_ls" }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "[g]o to [d]efinition (LSP)" })
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { desc = "[g]o to References (LSP)" })
    vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, { desc = "[g]o to [t]ype def" })
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "go to prev [d]iagnostic (LSP)" })
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "go to next [d]iagnostic (LSP)" })
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "quick info" })
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "[l]sp code [a]ctions" })
    vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, { desc = "[l]sp [d]iagnostics" })
    vim.keymap.set(
      "n",
      "<Leader>lf",
      function()
        require("conform").format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end,
      { desc = "[l]sp [f]ormat file" }
    )
    vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "[l]sp [i]nfo" })
    vim.keymap.set("n", "<leader>ll", "<cmd>LspLog<CR>", { desc = "[l]sp [l]ogs" })
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "[l]sp [r]ename" })
    vim.keymap.set("n", "<leader>lR", "<cmd>LspRestart<CR>", { desc = "[l]sp [R]estart" })
    vim.keymap.set("n", "<leader>ls", vim.lsp.buf.workspace_symbol, { desc = "[l]sp search for [s]ymbols" })

    vim.diagnostic.config {
      float = {
        border = "single",
        focusable = true,
        style = "minimal",
        source = true,
        header = "",
        prefix = "  ",
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
    }

    require("fidget").setup {
      notification = {
        window = {
          normal_hl = "NormalFloat",
          winblend = 0,
          border = "rounded",
          relative = "win",
        },
      },
    }

    light_switch.register {
      code = "twr",
      desc = "TailwindCSS LSP in Ruby",
      default = "off",
      enable = tw_setup,
      disable = tw_setup,
    }
  end,
}
