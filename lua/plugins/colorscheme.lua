return {
  {
    "rusty-scheme",
    dir = "~/repos/nvim-sandbox/rusty-scheme",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
    config = function()
      -- Spawning `defaults read` costs ~27ms, which is a third of startup, so
      -- the last known appearance is cached and trusted on the way up. The
      -- async check below corrects it within a frame or two if it went stale
      -- (i.e. the system theme changed while nvim was closed).
      local cache_path = vim.fn.stdpath "state" .. "/macos-appearance"

      local function cached_dark_mode()
        local ok, lines = pcall(vim.fn.readfile, cache_path)
        if ok and lines and lines[1] then return lines[1] == "dark" end
        -- no cache yet: pay for one synchronous read
        return vim.trim(vim.fn.system "defaults read -g AppleInterfaceStyle 2>/dev/null") == "Dark"
      end

      local function write_cache(dark) pcall(vim.fn.writefile, { dark and "dark" or "light" }, cache_path) end

      local function apply_colorscheme(dark)
        if dark then
          vim.cmd.colorscheme "rusty-scheme"
        else
          vim.cmd.colorscheme "rusty-scheme-light"
          vim.schedule(function()
            vim.api.nvim_set_hl(0, "Cursor", { bg = "#CC4400", fg = "#F9F5EE" })
            vim.api.nvim_set_hl(0, "TermCursor", { bg = "#CC4400", fg = "#F9F5EE" })
          end)
        end
      end

      local last_dark = cached_dark_mode()
      apply_colorscheme(last_dark)

      local function check_appearance()
        vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }, function(proc)
          -- exits non-zero in light mode, when the key is absent
          local dark = vim.trim(proc.stdout or "") == "Dark"
          if dark ~= last_dark then
            last_dark = dark
            -- this runs in a fast event context, where vim.fn is off limits;
            -- both the redraw and the cache write have to be scheduled
            vim.schedule(function()
              apply_colorscheme(dark)
              write_cache(dark)
            end)
          end
        end)
      end

      -- reconcile the cached guess, then poll for changes -- both off the UI thread
      write_cache(last_dark)
      vim.defer_fn(check_appearance, 0)

      local timer = vim.uv.new_timer()
      timer:start(5000, 5000, check_appearance)

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
