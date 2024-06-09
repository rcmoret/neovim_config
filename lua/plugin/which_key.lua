local wk = require("which-key")

wk.setup({
  plugins = {
    marks = false,
    registers = false,
  }
})

wk.register({
  f = {
    name = "File helpers",
    b = "Find Buffers",
    h = "Find Help Tags",
    g = "Live Git Grep",
    f = "Find Files",
  },
  c = { name = "Copy to Clipboard" },
  p = { name = "Paste from Clipboard" },
  P = {
    name = "Packer",
    s = { name = "Packer Sync" },
  },
  m = { name = "Mason Plugins" },
  s = { name = "Substitute Current Word (line)" },
  S = { name = "Substitute Current Word (file)" },
  x = { name = "Cut to Clipboard" },
}, { prefix = "<Leader>" })
