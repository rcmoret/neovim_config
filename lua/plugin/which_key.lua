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

wk.register({
  c = { name = "[c]opy to clipboard" },
  g = { name = "Git helpers", },
  m = { name = "Mason Plugins" },
  l = { name = "[l]sp commands" },
  p = { name = "[p]aste from clipboard" },
  P = { name = "[P]acker" },
  m = { name = "[m]ason plugins" },
  s = { name = "[s]ubstitute current word (line)" },
  S = { name = "[S]ubstitute current word (file)" },
  t = { name = "[t]elescope search" },
  x = { name = "[x] - cut to clipboard" },
}, { prefix = "<Leader>" })
