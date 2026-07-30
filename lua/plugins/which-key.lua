-- Single source of truth for leader-key group labels. Individual bindings stay
-- with whatever they configure; only the group names live here.

return {
  "folke/which-key.nvim",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        marks = false,
        registers = false,
      },
      presets = {
        z = false,
      },
    })

    wk.add({
      { "<Leader><Leader>", group = "vi remaps" },
      { "<Leader>b", group = "[b]uffer" },
      { "<Leader>f", group = "[f]ormat" },
      { "<Leader>g", group = "[g]it helpers" },
      { "<Leader>k", group = "la[z]y pkg manager" },
      { "<Leader>l", group = "[l]sp commands" },
      { "<Leader>n", group = "[n]otifications" },
      { "<Leader>r", group = "[r]esize buffers" },
      { "<Leader>t", group = "[t]ab commands" },
      { "t", group = "[t]elescope search" },
    })
  end,
}
