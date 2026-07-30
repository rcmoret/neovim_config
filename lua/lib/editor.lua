-- Small hand-rolled editor helpers. Pure functions over the current buffer;
-- keymaps for these live in lua/core/keymaps.lua.

local M = {}

function M.toggle_qf()
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

function M.jump_to_paragraph_start()
  local column = vim.fn.virtcol(".")
  if vim.fn.line(".") == (vim.fn.line("'{") + 1) then
    vim.fn.cursor(vim.fn.line(".") - 1, column)
  end
  local paragraph_start = vim.fn.line("'{")
  if paragraph_start == 1 then
    vim.fn.cursor(1, column)
  else
    vim.fn.cursor((paragraph_start + 1), column)
  end
end

function M.jump_to_paragraph_end()
  local column = vim.fn.virtcol(".")
  if vim.fn.line(".") == (vim.fn.line("'}") - 1) then
    vim.fn.cursor(vim.fn.line(".") + 1, column)
  end
  local paragraph_end = vim.fn.line("'}")
  if paragraph_end == vim.fn.line("$") then
    vim.fn.cursor(vim.fn.line("$"), column)
  else
    vim.fn.cursor((paragraph_end - 1), column)
  end
end

function M.duplicate_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_buf_set_lines(0, row, row, false, { line })
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

function M.duplicate_line_realign()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_buf_set_lines(0, row, row, false, { line })
  vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
  vim.cmd("normal! ==")
  vim.api.nvim_win_set_cursor(0, { row, col })
end

-- Select the text between the nearest pair of `|` on the current line.
-- `inner` excludes the pipes themselves.
function M.select_pipe_textobj(inner)
  local row, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local col = cur_col + 1 -- 1-indexed

  -- Search backward for opening |, skipping if cursor is already on one
  local open_col
  for c = (line:sub(col, col) == "|" and col - 1 or col), 1, -1 do
    if line:sub(c, c) == "|" then
      open_col = c
      break
    end
  end
  -- If cursor is on | and nothing found before it, treat it as the opening
  if not open_col and line:sub(col, col) == "|" then
    open_col = col
  end

  if not open_col then return end

  -- Search forward for closing | from after the opening
  local close_col
  for c = open_col + 1, #line do
    if line:sub(c, c) == "|" then
      close_col = c
      break
    end
  end

  if not close_col then return end

  -- Convert to 0-indexed for nvim API
  local s = inner and open_col or (open_col - 1)
  local e = inner and (close_col - 2) or (close_col - 1)

  if s > e then return end

  vim.api.nvim_win_set_cursor(0, { row, s })
  vim.cmd("normal! v")
  vim.api.nvim_win_set_cursor(0, { row, e })
end

return M
