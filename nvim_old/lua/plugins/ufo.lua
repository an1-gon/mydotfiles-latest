-- ~/.config/nvim/lua/plugins/folding.lua
-- Fixed nvim-ufo configuration with markdown-specific features

return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'VeryLazy',

  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      if filetype == 'markdown' then
        return { 'treesitter', 'indent' }
      else
        return { 'treesitter', 'indent' }
      end
    end,

    -- Custom fold virtual text: indent according to header level
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local line = vim.fn.getline(lnum)
      local indent = line:match '^(#+)' or ''

      -- Create indentation based on header level
      local prefix = ('  '):rep(math.max(0, #indent - 1))
      table.insert(virtText, 1, { prefix, 'Comment' })

      -- Add folded lines suffix
      local foldedLines = endLnum - lnum
      local suffix = (foldedLines > 1) and ((' \u{25B2} %d lines folded'):format(foldedLines)) or ((' \u{25B2} %d line folded'):format(foldedLines))
      table.insert(virtText, { suffix, 'Comment' })

      return virtText
    end,
  },

  init = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 2 -- Start with fold level 2 (H3+ open by default)
    vim.o.foldenable = true
    --  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  end,

  config = function(_, opts)
    require('ufo').setup(opts)

    local ufo = require 'ufo'

    -- Basic fold keymaps
    vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', '<Space>', 'za', { desc = 'Toggle fold under cursor' })

    -- Smart peek fold or LSP hover
    vim.keymap.set('n', 'zK', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek fold or LSP hover' })

    -- Optional: Markdown-specific keymaps for header level folding
    vim.keymap.set('n', 'z1', function()
      vim.opt.foldlevel = 0
    end, { desc = 'Fold all headers' })
    vim.keymap.set('n', 'z2', function()
      vim.opt.foldlevel = 1
    end, { desc = 'Show H1, fold H2+' })
    vim.keymap.set('n', 'z3', function()
      vim.opt.foldlevel = 2
    end, { desc = 'Show H1-H2, fold H3+' })
    vim.keymap.set('n', 'z4', function()
      vim.opt.foldlevel = 3
    end, { desc = 'Show H1-H3, fold H4+' })
  end,
}

-- ========================================
-- ALTERNATIVE: Manual Markdown Folding
-- ========================================
-- If you prefer manual control over treesitter, uncomment this section
-- and comment out the treesitter provider above

--[[
-- This creates a custom fold function specifically for markdown headers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- Override ufo for markdown files to use manual folding
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.MDfold(v:lnum)'
  end,
})

-- Global function for markdown folding
_G.MDfold = function(lnum)
  local line = vim.fn.getline(lnum)
  
  -- Match different header levels
  local h1 = line:match('^#%s')
  local h2 = line:match('^##%s')  
  local h3 = line:match('^###%s')
  local h4 = line:match('^####%s')
  local h5 = line:match('^#####%s')
  local h6 = line:match('^######%s')
  
  if h1 then
    return '>1'  -- Start fold level 1
  elseif h2 then
    return '>2'  -- Start fold level 2
  elseif h3 then
    return '>3'  -- Start fold level 3
  elseif h4 then
    return '>4'  -- Start fold level 4
  elseif h5 then
    return '>5'  -- Start fold level 5
  elseif h6 then
    return '>6'  -- Start fold level 6
  else
    return '='   -- Same fold level as previous line
  end
end
--]]
