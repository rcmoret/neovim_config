local harpoon = require("harpoon")

harpoon:setup()

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

local add_mark = function()
  harpoon:list():add()
end

vim.keymap.set("n",
  "<Leader>a",
  add_mark,
  { desc = "harpoon [a]dd mark" }
)
vim.keymap.set("n",
  "<Leader>h",
  function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), { title = "harpoon files", border = "rounded", ui_max_width = 120 })
  end,
  { desc = "[h]arpoon list" }
)
vim.keymap.set("n",
  "<Leader>H",
  function() toggle_telescope(harpoon:list()) end,
  { desc = "[H]arpoon list in telescope" }
 )

for n = 0, 9 do
  vim.keymap.set("n", "<Leader>" .. n, function() harpoon:list():select(n) end)
end

vim.keymap.set("n", "<Tab>", function() harpoon:list():next({ ui_nav_wrap = true }) end)
vim.keymap.set("n", "<S-Tab>", function() harpoon:list():prev({ ui_nav_wrap = true }) end)

require("which-key").add({
  { "<Leader>0", hidden = true },
  { "<Leader>1", group = "harpoon buffer @ [1]" },
  { "<Leader>2", hidden = true },
  { "<Leader>3", hidden = true },
  { "<Leader>4", hidden = true },
  { "<Leader>5", hidden = true },
  { "<Leader>6", hidden = true },
  { "<Leader>7", hidden = true },
  { "<Leader>8", hidden = true },
  { "<Leader>9", hidden = true },
})

harpoon:extend({
  UI_CREATE = function(cx)
    for n = 0, 9 do
      local keyname = tostring(n)

      vim.keymap.set("n", keyname, function() harpoon:list():select(n) end, { buffer = cx.bufnr })

      vim.keymap.set("n",
        "g" .. keyname,
        "<cmd>" ..keyname .. "<CR>",
        { buffer = cx.bufnr }
      )
    end

    local clear = function()
      vim.notify("Clearing harpoon list")
      harpoon:list():clear()
      require("harpoon.buffer").set_contents(cx.bufnr, {} )
    end

    vim.keymap.set("n", "da", clear, { buffer = cx.bufnr })
  end,
})
