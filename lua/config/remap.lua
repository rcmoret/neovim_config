vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex)

-- TABS
vim.keymap.set("n", "tt", "<cmd>tabnew<CR>")
vim.keymap.set("n", "tT", "<cmd>tab split<CR>")
vim.keymap.set("n", "tq", "<cmd>tabclose<CR>")
vim.keymap.set("n", "tQ", "<cmd>tabclose!<CR>")
vim.keymap.set("n", "tn", "<cmd>tabnext<CR>")
vim.keymap.set("n", "tN", "<cmd>tabmove +1<CR>")
vim.keymap.set("n", "tp", "<cmd>tabprev<CR>")
vim.keymap.set("n", "tP", "<cmd>tabmove -1<CR>")
vim.keymap.set("n", "t1", "1gt")
vim.keymap.set("n", "t2", "2gt")
vim.keymap.set("n", "t3", "3gt")
vim.keymap.set("n", "t4", "4gt")
vim.keymap.set("n", "t5", "5gt")
vim.keymap.set("n", "t6", "6gt")
vim.keymap.set("n", "t7", "7gt")
vim.keymap.set("n", "t8", "8gt")
vim.keymap.set("n", "t9", "9gt")
vim.keymap.set("n", "<Tab>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>tabprev<CR>")

-- SPLITS
vim.keymap.set("n", "|", "<cmd>vs<CR>")
vim.keymap.set("n", "\\", "<cmd>sp<CR>")

-- COPY / PASTE
vim.keymap.set("v", "<Leader>c", [["+y]])
vim.keymap.set({ "v", "n" }, "<Leader>p", [["+p]])
vim.keymap.set({ "v", "n" }, "<Leader>x", [["+x]])

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<Leader>s", [[:s/\(<C-r><C-w>\)/<C-r><C-w>/gcI<Left><Left><Left>]])
vim.keymap.set("n", "<Leader>S", [[:%s/\(<C-r><C-w>\)/<C-r><C-w>/gcI<Left><Left><Left>]])
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")

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

vim.keymap.set("n", "<Leader>q", toggle_qf, { desc = "[q]uick-fix list toggle " })
