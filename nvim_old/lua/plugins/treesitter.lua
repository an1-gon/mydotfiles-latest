return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- Fixed: Switch from master to main
  lazy = false,
  build = ':TSUpdate',

  config = function()
    -- Fixed: Use the updated module path
    local ts = require 'nvim-treesitter'

    -- The modern setup is highly minimal.
    -- Features like highlighting are now managed natively by Neovim.
    ts.setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    }

    -- Explicitly tell treesitter which parsers to fetch
    ts.install {
      'lua',
      'javascript',
      'html',
      'markdown',
      'css',
      'json',
      'bash',
      'dockerfile',
      'typescript',
      'vim',
      'yaml',
      'markdown_inline',
    }
  end,
}
