# nvim

Personal Neovim config. Requires **Neovim 0.12+** — 0.11 is enough for the
`vim.lsp.config` API and `vim.o.winborder`, but nvim-treesitter's `main` branch
hard-requires 0.12. Plugins are managed by
[lazy.nvim](https://github.com/folke/lazy.nvim), which bootstraps itself on
first launch.

## Layout

```
init.lua              load order, and nothing else
lua/
  core/
    options.lua       vim.opt settings; sets <Leader>
    lazy.lua          lazy.nvim bootstrap + :Lazy keymaps
    keymaps.lua       editor keymaps
    autocmds.lua      editor autocommands
  lib/
    light_switch.lua  the toggle framework behind <Leader>T
    editor.lua        small buffer helpers (quickfix toggle, paragraph
                      motions, line duplication, the `i|` text object)
  theme/
    icons.lua         nerd font glyphs, by category
    palette.lua       named colors, shared by lualine and nvim-notify
  plugins/            one file per plugin group, auto-imported by lazy
  private.lua         gitignored; database connections for dadbod
```

`init.lua` loads in a deliberate order — `options` first because it sets
`<Leader>` and nothing may map against it before that, then `lazy` (which runs
every plugin's `config`), then `keymaps` and `autocmds`.

There is no `after/` directory. Everything is an explicit module under `lua/`,
required in a known order. If you ever add `after/`, it should only hold real
runtime overrides such as `after/ftplugin/<ft>.lua` — not config.

## Conventions

- **One file per plugin group** in `lua/plugins/`, each returning a lazy spec.
  Related plugins that are configured together (all the git ones, the whole UI
  stack) share a file.
- **Plugin keymaps live with their plugin.** Editor keymaps live in
  `core/keymaps.lua`. The only thing that is centralized is which-key *group*
  labels, which are all in `plugins/which-key.lua` so the leader map is
  readable in one place.
- **Load order is expressed through `dependencies`,** never through file names.
- Most plugins are deferred behind `keys` / `cmd` / `ft` / `event`. When adding
  one, give it a trigger rather than defaulting to eager loading.

## External requirements

None of these are installed by the config; language servers are expected on
`$PATH` (there is no Mason).

| Tool | Used for | Install |
| --- | --- | --- |
| `rg` | telescope grep | `brew install ripgrep` |
| `prettier` | conform, JS/TS/CSS/JSON/YAML/MD | `npm i -g prettier` |
| `stylua` | conform, lua | `brew install stylua` |
| `tree-sitter` | building treesitter parsers | `brew install tree-sitter-cli` |
| `lua-language-server` | `lua_ls` | `brew install lua-language-server` |
| `typescript-language-server` | `ts_ls` | `npm i -g typescript-language-server` |
| `rust-analyzer` | `rust_analyzer` | `rustup component add rust-analyzer` |
| `tailwindcss-language-server` | `tailwindcss` | `npm i -g @tailwindcss/language-server` |
| `ruby-lsp` | `ruby_lsp`, via mise | `mise exec -- gem install ruby-lsp` |

Two plugins are loaded from local checkouts and must exist:

- `~/repos/nvim-sandbox/rusty-scheme` — the colorscheme (dark + light variants)
- `~/repos/nvim-sandbox/rusty-snip` — LuaSnip snippets

`lua/private.lua` is gitignored and must return a table; on a fresh machine
create it with `return {}`. It supplies `db_connections` to vim-dadbod.

### Ruby LSP and mise

`ruby-lsp` is installed as a gem per Ruby version through mise, not globally.
The spawn command uses mise's **full path** because `mise` is a shell function,
not a binary:

```lua
cmd = { vim.fn.expand "~/.local/bin/mise", "exec", "--", "ruby-lsp" }
```

That indirection costs a couple of seconds — `ruby_lsp` typically attaches
around 2s after opening a Ruby file, so give it a moment before assuming it is
broken.

Note that `brew install tree-sitter` is **not** enough — that formula ships only
the library. The binary comes from the separate `tree-sitter-cli` formula, and
the treesitter docs specifically warn against the npm build.

## Treesitter

Pinned to the `main` branch, which is a rewrite rather than a newer version of
`master`. There is no `ensure_installed` / `highlight` / `indent` options table:
the parser list lives at the top of `lua/plugins/treesitter.lua` and is passed
to `install()`, while highlighting and indentation are started per buffer by a
`FileType` autocmd.

Indentation is only enabled for languages that ship an `indents` query. Without
one, treesitter's `get_indent` never reaches its autoindent fallback and returns
0, which flattens the file rather than leaving indentation alone — so the
autocmd checks for the query before setting `indentexpr`.

Adding a language means adding it to `ensure_installed` and restarting, or
running `:TSInstall <lang>`.

## Toggles

`<Leader>T` opens the light-switch prompt; enter a code to flip it.

| Code | Toggles | Default |
| --- | --- | --- |
| `rel` | relative line numbers | on |
| `wr` | line wrap | off |
| `cmp` | code completion | on |
| `co` | color highlighting | on |
| `twr` | TailwindCSS LSP inside Ruby files | off |

Register new ones with `require("lib.light_switch").register { ... }`, passing
`code`, `desc`, `default`, and `enable` / `disable` (either a function or a
command string).

## Colorscheme

`rusty-scheme` follows the macOS system appearance. Reading that setting means
spawning `defaults read`, which costs ~27ms, so the last known value is cached
in `stdpath("state")/macos-appearance` and trusted at startup; an async check
corrects it within ~50ms if it went stale, and a 5s poll picks up changes while
nvim is running.

## Formatting

conform formats on save. To opt a project out, drop an empty `.no-format` file
at its root — conform walks up from the buffer's directory looking for one.

## Working on this config

```sh
stylua lua/ init.lua      # settings live in .stylua.toml
nvim --headless "+Lazy! sync" +qa
```

Two things to know when testing headlessly:

- `--headless` never fires `UIEnter`, so lazy's `VeryLazy` event never fires and
  anything gated on it looks unloaded. Force it with
  `require("lazy").load { plugins = { "name" } }`.
- `script -q /dev/null nvim ...` gives a real pty so `VeryLazy` does fire, but
  nvim gets EOF on stdin and exits after roughly six seconds — too short for
  anything that waits on an LSP.
