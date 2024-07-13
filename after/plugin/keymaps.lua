local wk = require("which-key")

wk.setup({
  plugins = {
    marks = false,
    registers = false,
  },
  presets = {
    z = false
  }
})

local toggle_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

local jump_to_paragraph_start = function()
  local column = vim.fn.virtcol(".")
  if vim.fn.line(".") == (vim.fn.line("'{") + 1) then
    vim.fn.cursor(vim.fn.line(".") - 1, column)
  end
  local paragraph_start = vim.fn.line("'{")
  if  paragraph_start == 1 then
    vim.fn.cursor(1, column)
  else
    vim.fn.cursor((paragraph_start + 1), column)
  end
end

local jump_to_paragraph_end = function()
  local column = vim.fn.virtcol(".")
  if vim.fn.line(".") == (vim.fn.line("'}") - 1) then
    vim.fn.cursor(vim.fn.line(".") + 1, column)
  end
  local paragraph_end = vim.fn.line("'}")
  if  paragraph_end == vim.fn.line("$") then
    vim.fn.cursor(vim.fn.line("$"), column)
  else
    vim.fn.cursor((paragraph_end - 1), column)
  end
end

vim.keymap.set("n", "(", jump_to_paragraph_start, { silent = true, desc = "move to last line of paragraph" })
vim.keymap.set("n", ")", jump_to_paragraph_end, { silent = true, desc = "move to last line of paragraph" })

-- TABS
vim.keymap.set("n", "tt", "<cmd>tabnew<CR>", { desc = "open new [t]ab" })
vim.keymap.set("n", "tq", "<cmd>tabclose<CR>", { desc = "[q]uit tab" })
vim.keymap.set("n", "tQ", "<cmd>tabclose!<CR>", { desc = "[q]uit ! tab" })
vim.keymap.set("n", "tn", "<cmd>tabnext<CR>", { desc = "[n]ext tab" })
vim.keymap.set("n", "tp", "<cmd>tabprev<CR>", { desc = "[p]rev tab" })
vim.keymap.set("n", "t1", "1gt", { desc = "go to [1]st tab" })
vim.keymap.set("n", "t2", "2gt", { desc = "go to [2]nd tab" })
vim.keymap.set("n", "t3", "3gt", { desc = "go to [3]rd tab" })
vim.keymap.set("n", "t4", "4gt", { desc = "go to [4]th tab" })
vim.keymap.set("n", "t5", "5gt", { desc = "go to [5]th tab" })
vim.keymap.set("n", "t6", "6gt", { desc = "go to [6]th tab" })
vim.keymap.set("n", "t7", "7gt", { desc = "go to [7]th tab" })
vim.keymap.set("n", "t8", "8gt", { desc = "go to [8]th tab" })
vim.keymap.set("n", "t9", "9gt", { desc = "go to [9]th tab" })

-- VIM
vim.keymap.set("n", "<Leader>w", "<cmd>w<CR>", { desc = "[w]rite remapped" })
vim.keymap.set("n", "<Leader>bd", "<cmd>bd<CR>", { desc = "[b]uffer [d]elte remapped" })
vim.keymap.set("n", "<Leader>be", "<cmd>be<CR>", { desc = "[b]uffer r[e]load" })
vim.keymap.set("n", "<Leader><Leader>q", "<cmd>q<CR>", { desc = "[q]uit remapped" })
vim.keymap.set("n", "<Leader><Leader>Q", "<cmd>q!<CR>", { desc = "[q]uit bang remapped" })
vim.keymap.set("n", "<Leader>q", toggle_qf, { desc = "[q]uick-fix list toggle " })
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
vim.keymap.set("n", "(", jump_to_paragraph_start, { silent = true, desc = "move to last line of paragraph" })
vim.keymap.set("n", ")", jump_to_paragraph_end, { silent = true, desc = "move to last line of paragraph" })

-- SPLITS
vim.keymap.set("n", "|", "<cmd>vs<CR>", { desc = "vertical split" })
vim.keymap.set("n", [[\]], "<cmd>sp<CR>", { desc = "horizontal split" })

-- COPY / PASTE
vim.keymap.set("v", "<Leader>c", [["+y]], { desc = "[c]opy to clipboard" })
vim.keymap.set({ "v", "n" }, "<Leader>p", [["+p]], { desc = "[p]aste from clipboard" })
vim.keymap.set({ "v", "n" }, "<Leader>P", [["+P]], { desc = "[P]aste from clipboard (put before)" })
vim.keymap.set({ "v", "n" }, "<Leader>x", [["+x]], { desc = "[x] - cut to clipboard" })
vim.keymap.set("n", "<Leader>d", "yyp", { desc = "[d]uplicate current line" })
vim.keymap.set("n", "<Leader>D", "yypv=gk", { desc = "[D]up current realign below", silent = true })


-- SUBSTITUTION
vim.keymap.set("n",
  "<Leader>s",
  [[:s/\(<C-r><C-w>\)/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
  { desc = "[s]ubstitute current word (line)" }
)
vim.keymap.set("n",
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

wk.add({
  { "<Leader><Leader>", group = "vi remaps" },
  { "<Leader>b", group ="[b]uffer" },
  { "<Leader>r", group = "[r]esize buffers" },
})
