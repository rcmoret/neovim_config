local utils = require("config.icons")
local icons = utils.icons

local toggle_explorer = function()
  vim.cmd("Neotree toggle")
end

local reveal_in_explorer = function()
  vim.cmd("Neotree toggle reveal_file=%:p")
end

vim.keymap.set("n", "<Leader>e", reveal_in_explorer, { desc = "[e]xplore file tree" })

local child_or_open = function(state)
  local node = state.tree:get_node()
  if node:has_children() then
    if not node:is_expanded() then -- if unexpanded, expand
      state.commands.toggle_node(state)
    else -- if expanded and has children, select the next child
      if node.type == "file" then
        state.commands.open(state)
      else
        require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
      end
    end
  else -- if has no children
    state.commands.open(state)
  end
end

local parent_or_close = function(state)
  local node = state.tree:get_node()
  if node:has_children() and node:is_expanded() then
    state.commands.toggle_node(state)
  else
    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
  end
end

require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
  sort_case_insensitive = false,
  sort_function = nil ,
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = nil,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = icons.ui.empty_folder,
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        added     = icons.git.add,
        modified  = icons.git.changed,
        deleted   = icons.git.deleted,
        renamed   = icons.git.renamed,
        untracked = icons.git.untracked,
        ignored   = icons.git.ignored,
        unstaged  = icons.git.unstaged,
        staged    = icons.git.staged,
        conflict  = icons.git.conflict
      }
    },
    file_size = {
      enabled = true,
      required_width = 64,
    },
    type = {
      enabled = true,
      required_width = 122,
    },
    last_modified = {
      enabled = true,
      required_width = 88,
    },
    created = {
      enabled = true,
      required_width = 110,
    },
    symlink_target = {
      enabled = false,
    },
  },
  commands = {},
  window = {
    position = "left",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    adaptive_size = true,
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel", -- close preview or floating neo-tree window
      ["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      -- Read `# Preview Mode` for more information
      ["l"] = child_or_open,
      ["h"] = parent_or_close,
      ["s"] = "open_split",
      ["v"] = "open_vsplit",
      ["<Leader>e"] = toggle_explorer,
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["C"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none"
        }
      },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      -- ["<"] = "prev_source",
      -- [">"] = "next_source",
      ["i"] = "show_file_details",
    }
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false, -- only works on Windows for hidden files/directories
    },
    follow_current_file = {
      enabled = false,
      leave_dirs_open = false,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = false,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["og"] = { "order_by_git_status", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
        -- ['<key>'] = function(state) ... end,
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
        -- ['<key>'] = function(state, scroll_padding) ... end,
      },
    },
    commands = {} -- Add a custom command or override a global one using the same function name
  },
})

require("nvim-web-devicons").setup({
  override = {
    ["rb"] = {
      name = "Rb",
      icon = "",
      cterm_color = "65",
      color = "#E57D7D"
    },
    ["erb"] = {
      name = "Erb",
      icon = "",
      cterm_color = "65",
      color = "#7FFFD4"
    },
  },
  override_by_name = {
    ["config.ru"] = {
      name = "Rb",
      icon = "",
      cterm_color = "65",
      color = "#E57D7D"
    },
    ["Rakefile"] = {
      name = "Rb",
      icon = "",
      cterm_color = "65",
      color = "#E57D7D"
    },
  },
  strict = false
})
