-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        ignorecase = false,
        inccommand = "",
        cindent = true,
        clipboard = {
          name = "xclip",
	        copy = {
		        ["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
		        ["*"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
	        },
	        paste = {
		        ["+"] = { "xclip", "-o", "-selection", "clipboard" },
		        ["*"] = { "xclip", "-o", "-selection", "clipboard" },
	        },
	        cache_enabled = 1, -- cache MUST be enabled, or else it hangs on dd/y/x and all other copy operations
        }
      },
      g = { -- vim.g.<key>
        ["$PATH"] = { "$HOME/.config/nvim" }
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      v = {
        ["J"] = { ":m '>+1<CR>gv=gv" },
        ["K"] = { ":m '<-2<CR>gv=gv" },
        ["<Leader>p"] = { "\"_dP" },
      },
      x = {
        ["<Leader>p"] = { "\"_dP" },
      },
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<Leader>bb"] = { "<cmd>Telescope buffers<cr>", desc = "Horizontal split buffer from tabline" },
        -- ["<C-p>"] = { "<cmd>Telescop find_files<cr>" },

        ["<Leader>b"] = { name = "Buffers" },
        ["<Leader>t"] = { desc = "Tab controls" },
        ["<Leader>gB"] = { "<cmd>GBrowse<cr>", desc = "Open in Browser" },
        ["<Leader>tt"] = { "<cmd>tabnew<cr>", desc = "Open new tab" },
        ["<Leader>tn"] = { "<cmd>tabnext<cr>", desc = "Go to next tab" },
        ["<Leader>tp"] = { "<cmd>tabprev<cr>", desc = "Go to previous tab" },
        ["<Leader>t1"] = { "1gt", desc = "Go to first tab" },
        ["<Leader>t2"] = { "2gt", desc = "Go to second tab" },
        ["<Leader>t3"] = { "3gt", desc = "Go to third tab" },
        ["<Leader>t4"] = { "4gt", desc = "Go to fourth tab" },
        ["<Leader>t5"] = { "5gt", desc = "Go to fifth tab" },
        ["<Leader>t6"] = { "6gt", desc = "Go to sixth tab" },
        ["<Leader>t7"] = { "7gt", desc = "Go to seventh tab" },
        ["<Leader>t8"] = { "8gt", desc = "Go to eigth tab" },
        ["<Leader>t9"] = { "9gt", desc = "Go to ninth tab" },
        ["<Tab>"] = { "<cmd>tabnext<cr>", desc = "Go to next tab" },
        ["<S-Tab>"] = { "<cmd>tabprev<cr>", desc = "Go to prev tab" },
        ["<Leader>fd"] = { "<cmd>Telescope dir live_grep<CR>", desc = "Find in directory" },

        ["J"] = { "mzJ`z" },
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },
        ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
