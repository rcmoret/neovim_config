local light_switch = require("plugin.light_switch")
vim.opt.completeopt = { "menu", "menuone" }
vim.opt.shortmess:append "c"

local cmp = require("cmp")
-- vim.g.cmptoggle = true

local utils = require("config.icons")
local icons = utils.icons
local match_exp = [[\k\+]]

local cmp_kinds = {
  Text = "  ",
  Method = "  ",
  Function = "  ",
  Constructor = "  ",
  Field = "  ",
  Variable = "  ",
  Class = icons.kinds.new.Class,
  Interface = "  ",
  Module = "  ",
  Property = "  ",
  Unit = "  ",
  Value = "  ",
  Enum = "  ",
  Keyword = "  ",
  Snippet = icons.kinds.icons_2.Snippet,
  Color = "  ",
  File = "  ",
  Reference = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "  ",
  Struct = "  ",
  Event = "  ",
  Operator = "  ",
  TypeParameter = "  ",
  LSP = icons.ui.lsp_hint .. "  "
}

light_switch.register({
  code = "cmp",
  desc = "Code completion",
  default = "on",
})

require("luasnip.loaders.from_vscode").load({
  include = { "ruby", "eruby" },
  paths = {
    "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    "~/repos/nvim-sandbox/rusty-snip"
  }
})

cmp.setup({
  enabled = function()
    local context = require("cmp.config.context")
    local is_comment = context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment")

    -- vim.notify(vim.inspect(light_switch.is_enabled("cmp")))
    return light_switch.is_enabled("cmp") and vim.bo.buftype ~= "prompt" and not(is_comment)
  end,
  view = {
    selection_order = "near_cursor",
    entries = "custom"
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        keyword_pattern = match_exp,
        keyword_length = 3,
      },
    },
    { name = "copilot" },
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<PageDown>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert, count = 5 },
    ["<PageUp>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert, count = 5 },
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:CmpSelect,Search:CmpSelect'
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:CmpSelect,Search:None'
    }),
  },
  formatting = {
    format = function (entry, vim_item)
      vim_item.dup = ({
        luasnip = 0,
        nvim_lsp = 0,
        buffer = 0,
      })[entry.source.name] or 0

      vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind

      return vim_item
    end
  }
})

cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "copilot" },
    { name = "buffer" }
  },
})

local ls = require("luasnip")

ls.config.set_config({
  history = false,
  updateevents = "TextChanged,TextChangedI",
})

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.jumpable() then
    ls.jump(1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })


-- vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = colors.float_bg })

-- vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = colors.float_bg })

-- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = colors.float_bg })

-- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = colors.float_bg })

-- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = colors.float_bg })

-- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = colors.float_bg })

-- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = colors.float_bg })

-- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = colors.float_bg })
-- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = colors.float_bg })
