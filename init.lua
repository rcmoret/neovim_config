-- Load order matters:
--   options  -- sets <Leader>, must run before anything maps against it
--   lazy     -- installs/loads plugins, runs each spec's config
--   keymaps  -- editor keymaps, may reference lib/ helpers
--   autocmds -- editor autocommands
require("core.options")
require("core.lazy")
require("core.keymaps")
require("core.autocmds")

-- Replaces the old textDocument/hover handler override; applies to all floats.
vim.o.winborder = "rounded"
