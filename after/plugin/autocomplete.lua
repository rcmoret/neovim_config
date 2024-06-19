vim.opt.completeopt = { "menu", "menuone" }
vim.opt.shortmess:append "c"
vim.g.cmptoggle = true

local cmp = require("cmp")
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

cmp.setup({
  enabled = function()
    local context = require("cmp.config.context")
    local is_comment = context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment")

    return vim.g.cmptoggle and vim.bo.buftype ~= "prompt" and not(is_comment)
  end,
  view = { selection_order = "near_cursor" },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        keyword_pattern = match_exp,
        keyword_length = 3,
        get_bufnrs = function()
          if vim.bo.buftype == "prompt" then
            return {}
          else
            return vim.api.nvim_list_bufs()
          end
        end,
      },
    },
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert, count = 5 },
    ["<C-u>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert, count = 5 },
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
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
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

vim.keymap.set("n", "[oc", "<cmd>lua vim.g.cmptoggle = true<CR>", { desc = "enable code [c]ompletion" })
vim.keymap.set("n", "]oc", "<cmd>lua vim.g.cmptoggle = false<CR>", { desc = "disable code [c]ompletion" })

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

require("luasnip.loaders.from_vscode").load({
  include = { "ruby", "eruby", "javascript" },
  paths = {
    "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    "~/repos/rusty-snip"
  }
})
