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
  ["<Leader>"] = { name = "vi remaps" },
  ["<Leader>b"] = { name = "[b]uffer" },
  c = { name = "[c]opy to clipboard" },
  g = { name = "[g]it helpers", },
  k = { name = "pac[k]er pkg manager" },
  l = { name = "[l]sp commands" },
  m = { name = "[m]ason plugins" },
  p = { name = "[p]aste from clipboard" },
  P = { name = "[P]acker" },
  s = { name = "[s]ubstitute current word (line)" },
  S = { name = "[S]ubstitute current word (file)" },
  t = { name = "[t]elescope search" },
  x = { name = "[x] - cut to clipboard" },
}, { prefix = "<Leader>" })
