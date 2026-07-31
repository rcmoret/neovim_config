-- nvim-treesitter `main` branch. This is a full rewrite of the plugin, not an
-- update: there is no `ensure_installed`/`highlight`/`indent` config table any
-- more. Parsers are installed imperatively, and highlighting and indentation
-- are started per buffer by the FileType autocmd below.
--
-- Requires Neovim 0.12+.

local ensure_installed = {
  "bash",
  "c",
  "css",
  "diff",
  "embedded_template", -- eruby
  "git_config",
  "git_rebase",
  "gitcommit",
  "graphql",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "printf",
  "query",
  "regex",
  "ruby",
  "rust",
  "scss",
  "sql",
  "svelte",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  -- eager: the FileType autocmd has to be registered before the first buffer
  -- is read, otherwise the initial file opens without highlighting
  lazy = false,
  config = function()
    -- async, and a no-op for parsers that are already present
    require("nvim-treesitter").install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      desc = "start treesitter highlighting and indentation where available",
      group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then return end

        -- fails when the parser is not installed yet; install() above runs
        -- asynchronously, so this is expected on a cold config
        if not pcall(vim.treesitter.start, args.buf, lang) then return end

        -- Indentation is experimental upstream and only some languages ship an
        -- `indents` query. Setting indentexpr without one collapses everything
        -- to column 0 rather than falling back to autoindent, so check first.
        if vim.treesitter.query.get(lang, "indents") then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
