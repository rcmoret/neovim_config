-- Expand a collapsed array / hash / HTML element onto multiple lines.
-- Keymaps live in lua/core/keymaps.lua.

local M = {}

function M.expand_array()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_row = cursor[1] - 1  -- 0-indexed
  local cur_col = cursor[2]

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Find opening [ by searching backward from cursor
  local open_row, open_col
  for r = cur_row, 0, -1 do
    local line = lines[r + 1]
    local end_col = (r == cur_row) and cur_col or #line - 1
    for c = end_col, 0, -1 do
      if line:sub(c + 1, c + 1) == "[" then
        open_row, open_col = r, c
        break
      end
    end
    if open_row then break end
  end

  if not open_row then
    vim.notify("No opening [ found", vim.log.levels.WARN)
    return
  end

  -- Find closing ] by searching forward from cursor
  local close_row, close_col
  for r = cur_row, #lines - 1 do
    local line = lines[r + 1]
    local start_col = (r == cur_row) and cur_col or 0
    for c = start_col, #line - 1 do
      if line:sub(c + 1, c + 1) == "]" then
        close_row, close_col = r, c
        break
      end
    end
    if close_row then break end
  end

  if not close_row then
    vim.notify("No closing ] found", vim.log.levels.WARN)
    return
  end

  -- Collect content between [ and ]
  local content_parts = {}
  for r = open_row, close_row do
    local line = lines[r + 1]
    local s = (r == open_row) and (open_col + 2) or 1
    local e = (r == close_row) and close_col or #line
    if s <= e then
      table.insert(content_parts, line:sub(s, e))
    end
  end
  local content = table.concat(content_parts, " ")

  -- Parse tokens (comma-delimited or whitespace-delimited)
  local tokens = {}
  if content:find(",") then
    for token in content:gmatch("[^,]+") do
      token = token:match("^%s*(.-)%s*$")
      if token ~= "" then table.insert(tokens, token) end
    end
  else
    for token in content:gmatch("%S+") do
      table.insert(tokens, token)
    end
  end

  if #tokens == 0 then
    vim.notify("No tokens found to expand", vim.log.levels.WARN)
    return
  end

  -- Build replacement lines
  local prefix_line = lines[open_row + 1]
  local indent = prefix_line:match("^(%s*)")
  local item_indent = indent .. "  "

  local new_lines = { prefix_line:sub(1, open_col + 1) }
  for _, token in ipairs(tokens) do
    table.insert(new_lines, item_indent .. token)
  end
  table.insert(new_lines, indent .. "]")

  vim.api.nvim_buf_set_lines(bufnr, open_row, close_row + 1, false, new_lines)
end

function M.expand_hash()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_row = cursor[1] - 1  -- 0-indexed
  local cur_col = cursor[2]

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Find opening { by searching backward from cursor
  local open_row, open_col
  for r = cur_row, 0, -1 do
    local line = lines[r + 1]
    local end_col = (r == cur_row) and cur_col or #line - 1
    for c = end_col, 0, -1 do
      if line:sub(c + 1, c + 1) == "{" then
        open_row, open_col = r, c
        break
      end
    end
    if open_row then break end
  end

  if not open_row then
    vim.notify("No opening { found", vim.log.levels.WARN)
    return
  end

  -- Find closing } by searching forward from cursor
  local close_row, close_col
  for r = cur_row, #lines - 1 do
    local line = lines[r + 1]
    local start_col = (r == cur_row) and cur_col or 0
    for c = start_col, #line - 1 do
      if line:sub(c + 1, c + 1) == "}" then
        close_row, close_col = r, c
        break
      end
    end
    if close_row then break end
  end

  if not close_row then
    vim.notify("No closing } found", vim.log.levels.WARN)
    return
  end

  -- Collect content between { and }
  local content_parts = {}
  for r = open_row, close_row do
    local line = lines[r + 1]
    local s = (r == open_row) and (open_col + 2) or 1
    local e = (r == close_row) and close_col or #line
    if s <= e then
      table.insert(content_parts, line:sub(s, e))
    end
  end
  local content = table.concat(content_parts, " ")

  -- Split on commas, respecting nested brackets and strings
  local pairs_list = {}
  local depth = 0
  local current = ""
  local in_string = false
  local string_char = nil

  for i = 1, #content do
    local ch = content:sub(i, i)
    if in_string then
      current = current .. ch
      if ch == string_char and content:sub(i - 1, i - 1) ~= "\\" then
        in_string = false
      end
    elseif ch == '"' or ch == "'" then
      in_string = true
      string_char = ch
      current = current .. ch
    elseif ch == "{" or ch == "[" or ch == "(" then
      depth = depth + 1
      current = current .. ch
    elseif ch == "}" or ch == "]" or ch == ")" then
      depth = depth - 1
      current = current .. ch
    elseif ch == "," and depth == 0 then
      local trimmed = current:match("^%s*(.-)%s*$")
      if trimmed ~= "" then table.insert(pairs_list, trimmed) end
      current = ""
    else
      current = current .. ch
    end
  end
  local last = current:match("^%s*(.-)%s*$")
  if last ~= "" then table.insert(pairs_list, last) end

  if #pairs_list == 0 then
    vim.notify("No hash pairs found to expand", vim.log.levels.WARN)
    return
  end

  -- Build replacement lines
  local prefix_line = lines[open_row + 1]
  local indent = prefix_line:match("^(%s*)")
  local item_indent = indent .. "  "

  local new_lines = { prefix_line:sub(1, open_col + 1) }
  for _, pair in ipairs(pairs_list) do
    table.insert(new_lines, item_indent .. pair .. ",")
  end
  table.insert(new_lines, indent .. "}")

  vim.api.nvim_buf_set_lines(bufnr, open_row, close_row + 1, false, new_lines)
end

function M.expand_html()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_row = cursor[1] - 1
  local cur_col = cursor[2]

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Search backward for nearest opening tag <tagname
  local open_row, open_col, tag_name
  for r = cur_row, 0, -1 do
    local line = lines[r + 1]
    local end_col = (r == cur_row) and cur_col or #line
    for c = end_col, 1, -1 do
      if line:sub(c, c) == "<" then
        local name = line:sub(c + 1):match("^([a-zA-Z][a-zA-Z0-9%-]*)")
        if name then
          open_row, open_col, tag_name = r, c - 1, name  -- open_col is 0-indexed
          break
        end
      end
    end
    if open_row then break end
  end

  if not open_row then
    vim.notify("No opening HTML tag found", vim.log.levels.WARN)
    return
  end

  -- Find end of opening tag (the >)
  local open_end_row, open_end_col
  for r = open_row, #lines - 1 do
    local line = lines[r + 1]
    local s = (r == open_row) and (open_col + 1) or 1
    for c = s, #line do
      if line:sub(c, c) == ">" then
        open_end_row, open_end_col = r, c - 1  -- 0-indexed
        break
      end
    end
    if open_end_row then break end
  end

  if not open_end_row then
    vim.notify("Malformed opening tag", vim.log.levels.WARN)
    return
  end

  -- Find matching closing tag, tracking depth for nested same-tag elements
  local close_row, close_col, close_end_col
  local depth = 1
  for r = open_end_row, #lines - 1 do
    local line = lines[r + 1]
    local s = (r == open_end_row) and (open_end_col + 2) or 1
    local i = s
    while i <= #line do
      if line:sub(i, i) == "<" then
        local rest = line:sub(i + 1)
        if rest:match("^/" .. tag_name .. "[%s>]") or rest:match("^/" .. tag_name .. "$") then
          depth = depth - 1
          if depth == 0 then
            close_row = r
            close_col = i - 1  -- 0-indexed start of </tag>
            close_end_col = (line:find(">", i) or i) - 1  -- 0-indexed end of </tag>
            break
          end
        elseif rest:match("^" .. tag_name .. "[%s>/]") or rest:match("^" .. tag_name .. "$") then
          depth = depth + 1
        end
      end
      i = i + 1
    end
    if close_row then break end
  end

  if not close_row then
    vim.notify("No closing </" .. tag_name .. "> found", vim.log.levels.WARN)
    return
  end

  -- Collect inner content between > and </
  local content_parts = {}
  for r = open_end_row, close_row do
    local line = lines[r + 1]
    local s = (r == open_end_row) and (open_end_col + 2) or 1
    local e = (r == close_row) and close_col or #line
    if s <= e then table.insert(content_parts, line:sub(s, e)) end
  end
  local content = table.concat(content_parts, " "):match("^%s*(.-)%s*$")

  if content == "" then
    vim.notify("No content to expand", vim.log.levels.WARN)
    return
  end

  -- Split content into top-level child elements, tracking tag depth
  local children = {}
  local current = ""
  local child_depth = 0
  local i = 1

  while i <= #content do
    if content:sub(i, i) == "<" then
      local tag_end = content:find(">", i)
      if not tag_end then
        current = current .. content:sub(i)
        break
      end
      local tag = content:sub(i, tag_end)
      if tag:sub(1, 2) == "</" then
        current = current .. tag
        child_depth = child_depth - 1
        i = tag_end + 1
        if child_depth == 0 then
          local trimmed = current:match("^%s*(.-)%s*$")
          if trimmed ~= "" then table.insert(children, trimmed) end
          current = ""
        end
      elseif tag:sub(-2) == "/>" then
        current = current .. tag
        i = tag_end + 1
        if child_depth == 0 then
          local trimmed = current:match("^%s*(.-)%s*$")
          if trimmed ~= "" then table.insert(children, trimmed) end
          current = ""
        end
      else
        child_depth = child_depth + 1
        current = current .. tag
        i = tag_end + 1
      end
    else
      current = current .. content:sub(i, i)
      i = i + 1
    end
  end
  local remaining = current:match("^%s*(.-)%s*$")
  if remaining ~= "" then table.insert(children, remaining) end

  if #children == 0 then
    vim.notify("No children found to expand", vim.log.levels.WARN)
    return
  end

  -- Build replacement: preserve everything up to and including the opening tag's >
  local indent = lines[open_row + 1]:match("^(%s*)")
  local item_indent = indent .. "  "

  local new_lines = {}
  for r = open_row, open_end_row do
    local line = lines[r + 1]
    table.insert(new_lines, r == open_end_row and line:sub(1, open_end_col + 1) or line)
  end
  for _, child in ipairs(children) do
    table.insert(new_lines, item_indent .. child)
  end
  table.insert(new_lines, indent .. "</" .. tag_name .. ">")

  vim.api.nvim_buf_set_lines(bufnr, open_row, close_row + 1, false, new_lines)
end

return M
