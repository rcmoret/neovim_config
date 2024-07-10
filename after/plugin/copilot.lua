local copilot = require("copilot")
local panel = require("copilot.panel")

require("copilot_cmp").setup()

require("which-key").register({ C = { name = "[C]opilot", }, }, { prefix = "<Leader>" })

vim.g.ghcp_panel_open = false
copilot.setup({})

local light_switch = require("plugin.light_switch")

light_switch.register({
  code = "cps",
  desc = "GitHub Copilot Suggestions",
  default = "on",
  enable = function()
    vim.b.copilot_suggestion_hidden = true
  end,
  disable = function()
    vim.b.copilot_suggestion_hidden = false
  end
})

light_switch.register({
  code = "cpp",
  desc = "GitHub Copilot Panel",
  default = "off",
  enable = panel.open,
  disable = panel.teardown,
})
