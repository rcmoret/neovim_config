return {
  {
    "rusty-scheme",
    dir = "~/repos/nvim-sandbox/rusty-scheme",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
    config = function()
      local function is_dark_mode()
        local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
        return vim.trim(result) == "Dark"
      end

      local function apply_colorscheme()
        if is_dark_mode() then
          vim.cmd.colorscheme "rusty-scheme"
        else
          vim.cmd.colorscheme "rusty-scheme-light"
          vim.schedule(function()
            vim.api.nvim_set_hl(0, "Cursor", { bg = "#CC4400", fg = "#F9F5EE" })
            vim.api.nvim_set_hl(0, "TermCursor", { bg = "#CC4400", fg = "#F9F5EE" })
          end)
        end
      end

      apply_colorscheme()

      -- Poll every 5 seconds for macOS appearance changes
      local timer = vim.uv.new_timer()
      local last_dark = is_dark_mode()
      timer:start(5000, 5000, vim.schedule_wrap(function()
        local dark = is_dark_mode()
        if dark ~= last_dark then
          last_dark = dark
          apply_colorscheme()
        end
      end))

      vim.api.nvim_create_autocmd("VimLeavePre", {
        desc = "stop the appearance-polling timer on exit",
        group = vim.api.nvim_create_augroup("ColorschemePollStop", { clear = true }),
        callback = function()
          if timer and not timer:is_closing() then
            timer:stop()
            timer:close()
          end
        end,
      })

      -- keep these / don't change!
      vim.api.nvim_set_hl(0, "@lsp.type.variable.ruby", {})
      vim.api.nvim_set_hl(0, "@lsp.type.method.ruby", {})
      vim.api.nvim_set_hl(0, "@lsp.type.parameter.ruby", {})
      vim.api.nvim_set_hl(0, "@lsp.type.class.ruby", {})
    end,
  },
  { "folke/tokyonight.nvim", lazy = true },
}
