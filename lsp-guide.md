# LSP Guide

Native LSP management for this config. No Mason — server binaries are installed
via `brew`, `pnpm`, or `mise`; nvim wires them up with `vim.lsp.config` +
`vim.lsp.enable`.

Key file: `after/plugin/lsp.lua`.

## How it's wired

1. `vim.lsp.config("*", { ... })` sets defaults merged into every server
   (capabilities, UI border).
2. Each server gets its own block:
   ```lua
   vim.lsp.config.<name> = {
     cmd = { "<binary>", ...args },
     filetypes = { ... },
     root_markers = { ... },
     init_options = { ... },   -- sent in the LSP initialize handshake
     settings = { ... },       -- sent via workspace/didChangeConfiguration
   }
   ```
3. `vim.lsp.enable { "<name>", ... }` tells nvim to auto-attach each server to
   buffers matching its `filetypes` (resolving `root_dir` from `root_markers`).

## Debugging

### Is the server attached?
```vim
:LspInfo
```
Shows attached clients for the current buffer plus their `root_dir`. If nothing
attaches, either the filetype doesn't match the config or no `root_markers` were
found.

### What config did the running client actually start with?
```vim
:lua =vim.lsp.get_clients({name="<server>"})[1].config
:lua =vim.lsp.get_clients({name="<server>"})[1].config.cmd
:lua =vim.lsp.get_clients({name="<server>"})[1].config.init_options
:lua =vim.lsp.get_clients({name="<server>"})[1].config.root_dir
```
If this doesn't match what's in `lsp.lua`, something's overriding it — or the
client was started before your most recent edit.

### Re-source vs. restart
Editing `lsp.lua` and re-sourcing it (`<leader>lR`) updates
`vim.lsp.config.<server>` but does **not** restart already-running clients.
`init_options` are only negotiated during the LSP `initialize` handshake, so a
running client keeps its old settings.

To apply config changes:
```vim
:LspRestart <server>
```
Or quit and reopen nvim.

### Verbose logs
```vim
:lua vim.lsp.set_log_level("debug")
:LspRestart <server>
:LspLog
```
Search for `"initializationOptions"` to see what nvim sent the server. Search
for `stderr` entries to see server crashes.

### Binary resolution
nvim spawns `cmd[0]` through its own PATH. In a regular shell:
```bash
which <binary>
```
If it resolves but nvim can't find it, your shell PATH and nvim PATH differ.
Use an absolute path in `cmd` (as we do with `mise`), or ensure the binary's
directory is on nvim's PATH.

### Health check
```vim
:checkhealth vim.lsp
```

### The mise + Ruby pattern
For tools where the version is project-specific (Ruby), use `mise exec --`
without pinning a version:
```lua
cmd = { "/Users/ryanmoret/.local/bin/mise", "exec", "--", "ruby-lsp" }
```
mise reads `.tool-versions` / `.ruby-version` from the LSP's `cwd` (which is
`root_dir`) and activates the right version per project. The `ruby-lsp` gem
must be installed for each Ruby version you use.

## Common pitfalls we've hit

- **Wrong setting key.** If a setting silently has no effect, verify the exact
  key in the server's source — not docs, which can lag. Ruby LSP's setting is
  `enablePendingMigrationsPrompt`, not `pendingMigrationsPrompt`.
- **Init options don't update on re-source.** Running clients keep their
  original handshake settings; restart the client.
- **Config replacement.** Assigning `vim.lsp.config.x = { ... }` *replaces* the
  entry. If you want to merge into existing defaults, use the call form:
  `vim.lsp.config("x", { ... })`.
- **Stale binaries from a previous tool manager.** If `which <server>` still
  points into `~/.local/share/nvim/mason/bin/...` or similar, remove those
  dirs so the real install takes precedence.

## Example: adding Python

Using `pyright` (Microsoft's Python language server).

### 1. Install the binary

```bash
pnpm add -g pyright
```

Verify:
```bash
which pyright-langserver
# -> ~/Library/pnpm/pyright-langserver
```

### 2. Add the config block

In `after/plugin/lsp.lua`, alongside the other `vim.lsp.config.*` blocks:

```lua
vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
```

### 3. Add it to the enable list

```lua
vim.lsp.enable { "ruby_lsp", "ts_ls", "rust_analyzer", "tailwindcss", "lua_ls", "pyright" }
```

### 4. Verify

Quit and reopen nvim, open any `.py` file, then:

```vim
:LspInfo
:lua =vim.lsp.get_clients({name="pyright"})[1].config.root_dir
```

### Swapping flavors

Prefer a different Python LSP? Same shape, different binary and `cmd`:

- `basedpyright` — `pnpm add -g basedpyright`, then
  `cmd = { "basedpyright-langserver", "--stdio" }`
- `ruff` (linter/formatter LSP) — `brew install ruff`, then
  `cmd = { "ruff", "server" }`; filetypes and markers unchanged

You can run both side-by-side (pyright for type-aware features, ruff for
linting/format) by giving each its own `vim.lsp.config.*` block and adding both
names to `vim.lsp.enable { ... }`.

### Per-project venv handling

pyright picks up the interpreter automatically from `pyproject.toml` or a local
`venv/`. If you use `mise` for Python too, mirror the Ruby approach:

```lua
cmd = { "/Users/ryanmoret/.local/bin/mise", "exec", "--", "pyright-langserver", "--stdio" }
```

This activates whatever Python version mise resolves for the project before
launching the server.
