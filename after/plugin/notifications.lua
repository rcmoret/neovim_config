local noice = require("noice")

local colors = require("config.rusty-scheme")

require("notify").setup({
  background_colour = colors.white,
  render = "simple",
  stages = "fade_in_slide_out",
  timeout = 200
})

noice.setup({
  cmdline = {
    view = "cmdline_popup"
  },
  notify = {
    enabled = true,
    timeout = 800,
    view = "notify"
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
          { find = "line less" },
          { find = "more line" },
          { find = "fewer line" },
          { find = "lines yanked" },
          { event = "msg_show", kind = "search_count" }
        },
      },
      opts = { skip = true },
    },
  },
})

-- ERROR
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.light_red, bg=colors.near_black })
vim.api.nvim_set_hl(0, "NotifyERRORBody", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyERRORIcon", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { link = "NormalFloat" })

-- WARN
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg= colors.yellow, bg=colors.near_black })
vim.api.nvim_set_hl(0, "NotifyWARNBody", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyWARNIcon", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { link = "NormalFloat" })

-- INFO
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.dark_blue, bg = colors.near_black })
vim.api.nvim_set_hl(0, "NotifyINFOBody", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyINFOIcon", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { link = "NormalFloat" })

-- DEBUG
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.orange, bg = colors.near_black })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { link = "NormalFloat" })

-- TRACE
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.light_green, bg = colors.near_black })
vim.api.nvim_set_hl(0, "NotifyTRACEBody", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { link = "NormalFloat" })

vim.api.nvim_set_hl(0, "NotifyLogTime", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "NotifyLogTitle", { link = "NormalFloat" })

local test_notifications = function()
  local prompt = ([[
  (1): default / info
  (2): warn
  (3): error

  ]]
  )
  local choice = vim.fn.input(prompt)
  if choice == "1" then
    vim.notify("this is an informational message", vim.log.levels.INFO)
  elseif choice == "2" then
    vim.notify("this would be a warning", vim.log.levels.WARN)
  elseif choice == "3" then
    vim.notify("oh no, there was an error", vim.log.levels.ERROR)
  else
    vim.notify("I see you like to do your own thing; '" .. choice .. "' renders a default message")
  end
end

require("which-key").add({ "<Leader>n", group = "[n]otifications" })

vim.keymap.set("n", "<Leader>ne", function() noice.cmd("enable") end, { desc = "[n]otifications: [e]nable" })
vim.keymap.set("n", "<Leader>nd", function() noice.cmd("disable") end, { desc = "[n]otifications: [d]isable" })
vim.keymap.set("n", "<Leader>nh", function() noice.cmd("history") end, { desc = "[n]otifications: [h]istory" })
vim.keymap.set("n", "<Leader>nn", test_notifications, { desc = "[n]otifications: send [n]otifictions" })
vim.keymap.set("n", "<Leader>nt", function() noice.cmd("telescope") end, { desc = "[n]otifications: history in [t]elescope" })
vim.keymap.set("n", "<Leader>ni", function ()
   vim.cmd("Inspect")
end, { desc = "[n]otify the result of [i]nspect" })
