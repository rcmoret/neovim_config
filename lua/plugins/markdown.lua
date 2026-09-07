return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup {
      code = {
        width = "block",
        right_pad = 2,
      },
    }

    -- render-markdown links its code backgrounds to ColorColumn, which in
    -- rusty-scheme is a mid gray (#4f5258) a shade off Comment (#4a5d68), so
    -- comments inside a fenced block vanish. NormalFloat tracks the light and
    -- dark palettes and only lifts a little off Normal.
    local function code_colors()
      local float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = float.bg })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = float.bg })
    end

    code_colors()

    vim.api.nvim_create_autocmd("ColorScheme", {
      desc = "keep markdown code backgrounds in step with the palette",
      group = vim.api.nvim_create_augroup("RenderMarkdownColors", { clear = true }),
      callback = code_colors,
    })

    require("lib.light_switch").register {
      code = "md",
      desc = "Markdown render",
      default = "on",
      enable = "RenderMarkdown enable",
      disable = "RenderMarkdown disable",
    }
  end,
}
