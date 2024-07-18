local settings = {}

local toggleable = {}

local light_switch = function ()
  local prompt = ""
  for key, value in pairs(toggleable) do
    prompt = prompt .. string.format("%-5s %-40s %4s", key, value.desc, settings[key]) .. "\n"
  end

  -- local bufnr = vim.api.nvim_get_current_buf()
  vim.notify(prompt)
  local option = vim.fn.input(prompt)

  local configuration = toggleable[option]

  if not(configuration) then
    vim.notify("Invalid option: " .. vim.inspect(option), vim.log.levels.WARN)
    return
  else
    toggleable[option].toggle()
  end
end

vim.keymap.set("n", "<Leader>T", light_switch, { desc = "light-switch super [T]oggle" })

local is_enabled = function (code)
  return settings[code] == "on"
end

local run = function(callback)
  if type(callback) == "string" then
    vim.cmd(callback)
  elseif type(callback) == "function" then
    callback()
  end
end

local toggle_on = function(code, callback)
  settings[code] = "on"
  run(callback)
end

local toggle_off = function(code, callback)
  settings[code] = "off"
  run(callback)
end

local register = function(options)
  settings[options.code] = options.default

  if options.default == "on" then
    run(options.enable)
  end

  toggleable[options.code]= {
    desc = options.desc,
    toggle = function()
      if not(is_enabled(options.code)) then
        toggle_on(options.code, options.enable)
      else
        toggle_off(options.code, options.disable)
      end
    end
  }
end

return {
  is_enabled = is_enabled,
  register = register
}
