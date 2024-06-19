vim.opt.completeopt = { "menu", "menuone" }
vim.opt.shortmess:append "c"

local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
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

require("luasnip.loaders.from_vscode").load({
  -- include = { "ruby", "eruby" },
  include = { "ruby", "eruby", "javascript" },
  paths = {
    "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    "~/repos/rusty-snip"
  }
})
