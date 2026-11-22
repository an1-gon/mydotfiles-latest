return {
  {
    'dkarter/bullets.vim',
    ft = { 'markdown', 'text' }, -- only load for Markdown and plain text
    config = function()
      -- optional: customize bullets.vim settings here
      vim.g.bullets_enabled_file_types = { 'markdown', 'text' }
    end,
  },
}
