return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },

  -- Put your vim.lsp configuration here
  config = function(_, opts)
    -- Set up blink.cmp first
    require('blink.cmp').setup(opts)

    -- Now configure LSP servers using vim.lsp API
    vim.lsp.config('luals', {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
        },
      },
    })

    -- Configure Marksman for Markdown
    vim.lsp.config('marksman', {
      cmd = { 'marksman', 'server' },
      filetypes = { 'md', 'markdown', 'markdown.mdx' },
      root_markers = { '.marksman.toml', '.git' },
      settings = {
        -- Marksman-specific settings (optional)
        marksman = {
          -- Enable completion for wiki links
          wiki_link_completion = true,
          -- Enable diagnostics for broken wiki links
          diagnostics = {
            wiki_link_title_suggest = true,
          },
        },
      },
    })

    -- Enable the LSP server
    vim.lsp.enable 'luals'
    vim.lsp.enable 'marksman'

    -- Set up LSP keymaps
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true, noremap = true }
        --Force override any existing gd mapping
        vim.keymap.set('n', '<leader>gd', function()
          vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      end,
    })
  end,
}
