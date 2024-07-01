require("notify").setup({
  background_colour = "#FFFFFF",
  render = "simple",
  stages = "fade_in_slide_out",
  timeout = 200
})

require("noice").setup({
  cmdline = {
    view = "cmdline"
  },
  presets = {
    bottom_search = true,
  },
  notify = {
    enabled = true,
    view = "popup",
    timeout = 200,
  },
  lsp = {
    progress = {
      enabled = false
    }
  },
  routes = {
    {
      filter = {
        any = {
          { find = "written" },
          { find = "less line" },
          { find = "more line" },
          { find = "fewer line" },
          { find = "lines yanked" },
        },
      },
      opts = { skip = true },
    },
  },
})

vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg="#00ffff", bg="none" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg="#ffd60a", bg="none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg="#f48c06", bg="none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg="#06d6a0", bg="none" })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg="#ff006e", bg="none" })

vim.cmd([[
    hi link NotifyERRORIcon Normal
    hi link NotifyERRORTitle  Normal

    hi link NotifyWARNIcon Normal
    hi link NotifyWARNTitle Normal

    hi link NotifyINFOIcon Normal
    hi link NotifyINFOTitle Normal

    hi link NotifyDEBUGIcon Normal
    hi link NotifyDEBUGTitle  Normal

    hi link NotifyTRACEIcon Normal
    hi link NotifyTRACETitle  Normal

    hi link NotifyLogTime Normal
    hi link NotifyLogTitle Normal
]])
