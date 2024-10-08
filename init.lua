require("config")
require("plugin")
require("plugin.light_switch")

P = function(table)
  print(vim.inspect(table))
  return table
end
