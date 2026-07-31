-- Editor keymaps. Plugin keymaps live with their spec in lua/plugins/;
-- which-key group labels are declared in lua/plugins/which-key.lua.

local editor = require "lib.editor"
local light_switch = require "lib.light_switch"

-- PARAGRAPH MOTIONS
vim.keymap.set(
  { "n", "v" },
  "(",
  editor.jump_to_paragraph_start,
  { silent = true, desc = "move to first line of paragraph" }
)
vim.keymap.set(
  { "n", "v" },
  ")",
  editor.jump_to_paragraph_end,
  { silent = true, desc = "move to last line of paragraph" }
)

-- TABS
vim.keymap.set("n", "<Leader>tt", "<cmd>tabnew<CR>", { desc = "open new [t]ab" })
vim.keymap.set("n", "<Leader>tq", "<cmd>tabclose<CR>", { desc = "[q]uit tab" })
vim.keymap.set("n", "<Leader>tQ", "<cmd>tabclose!<CR>", { desc = "[q]uit ! tab" })
vim.keymap.set("n", "<Leader>tn", "<cmd>tabnext<CR>", { desc = "[n]ext tab" })
vim.keymap.set("n", "<Leader>tp", "<cmd>tabprev<CR>", { desc = "[p]rev tab" })
for i = 1, 9 do
  vim.keymap.set("n", "<Leader>t" .. i, i .. "gt", { desc = "go to tab " .. i })
end

-- VIM
vim.keymap.set("n", "<Leader>w", "<cmd>w<CR>", { desc = "[w]rite remapped" })
vim.keymap.set("n", "<Leader>bd", "<cmd>bd<CR>", { desc = "[b]uffer [d]elte remapped" })
vim.keymap.set("n", "<Leader>be", "<cmd>be<CR>", { desc = "[b]uffer r[e]load" })
vim.keymap.set("n", "<Leader><Leader>q", "<cmd>q<CR>", { desc = "[q]uit remapped" })
vim.keymap.set("n", "<Leader><Leader>Q", "<cmd>q!<CR>", { desc = "[q]uit bang remapped" })
vim.keymap.set("n", "<Leader>q", editor.toggle_qf, { desc = "[q]uick-fix list toggle " })
vim.keymap.set({ "v", "n", "i", "s" }, "<C-[>", "<Esc>", { desc = "" })
vim.keymap.set("n", "<Leader><Leader>s", "<cmd>so<CR>", { desc = "[s]ource current file" })
vim.keymap.set("n", "<Leader><Leader>z", "<cmd>wq<CR>", { desc = "write and e[z]it" })
vim.keymap.set({ "n", "v", "x" }, "H", "^", { silent = true })
vim.keymap.set({ "n", "v", "x" }, "yH", "mQ0y$`Q", { silent = true, desc = "yank to the end of the line" })
vim.keymap.set({ "n", "v", "x" }, "L", "$", { silent = true })
vim.keymap.set({ "n", "v", "x" }, "cL", "c$", { silent = true, desc = "change to the end of the line" })
vim.keymap.set({ "n", "v", "x" }, "dL", "d$", { silent = true, desc = "delete to the end of the line" })
vim.keymap.set({ "n", "v", "x" }, "yL", "y$", { silent = true, desc = "yank to the end of the line" })
vim.keymap.set({ "n", "v", "x" }, "M", "%", { silent = true })
vim.keymap.set({ "n", "v", "x" }, "yM", "%y%", { silent = true, desc = "yank between pairs" })
vim.keymap.set("v", "p", [["_dp]], { silent = true })
vim.keymap.set("v", "P", [["_dP]], { silent = true })
vim.api.nvim_set_keymap("n", "<", "[", { silent = true })
vim.api.nvim_set_keymap("n", ">", "]", { silent = true })

-- SPLITS
vim.keymap.set("n", "|", "<cmd>vs<CR>", { desc = "vertical split" })
vim.keymap.set("n", [[\]], "<cmd>sp<CR>", { desc = "horizontal split" })

-- COPY / PASTE
vim.keymap.set("v", "<Leader>c", [["+y]], { desc = "[c]opy to clipboard" })
vim.keymap.set({ "v", "n" }, "<Leader>p", [["+p]], { desc = "[p]aste from clipboard" })
vim.keymap.set({ "v", "n" }, "<Leader>P", [["+P]], { desc = "[P]aste from clipboard (put before)" })
vim.keymap.set({ "v", "n" }, "<Leader>x", [["+x]], { desc = "[x] - cut to clipboard" })
vim.keymap.set("n", "<Leader>d", editor.duplicate_line, { desc = "[d]uplicate current line", silent = true })
vim.keymap.set("n", "<Leader>D", editor.duplicate_line_realign, { desc = "[D]up current realign below", silent = true })

-- SUBSTITUTION
vim.keymap.set(
  "n",
  "<Leader>s",
  [[:s/\(<C-r><C-w>\)/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
  { desc = "[s]ubstitute current word (line)" }
)
vim.keymap.set(
  "n",
  "<Leader>S",
  [[:%s/\(<C-r><C-w>\)/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
  { desc = "[S]ubstitute current word (file)" }
)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "J", "mzJ`z")

-- RESIZING
vim.keymap.set("n", "<Leader>rn", "<C-w>5<", { desc = "adjust bfr size [n]arrow-er" })
vim.keymap.set("n", "<Leader>rs", "<C-w>5-", { desc = "adjust bfr size [s]horter" })
vim.keymap.set("n", "<Leader>rt", "<C-w>5+", { desc = "adjust bfr size [t]aller" })
vim.keymap.set("n", "<Leader>rw", "<C-w>5>", { desc = "adjust bfr size [w]ider" })
vim.keymap.set("n", "<Leader>rz", "<C-w>_<C-w>|", { desc = "full si[z]e" })
vim.keymap.set("n", "<Leader>rZ", "<C-w>=", { desc = "even si[Z]e" })
vim.keymap.set("n", "<Leader>re", "<C-w>=", { desc = "resize buffers [=] evenly" })

-- CUSTOM TEXT OBJECTS
vim.keymap.set({ "x", "o" }, "i|", function() editor.select_pipe_textobj(true) end, { desc = "inner pipe text object" })
vim.keymap.set(
  { "x", "o" },
  "a|",
  function() editor.select_pipe_textobj(false) end,
  { desc = "around pipe text object" }
)

-- LIGHT SWITCH
vim.keymap.set("n", "<Leader>T", light_switch.prompt, { desc = "light-switch super [T]oggle" })
