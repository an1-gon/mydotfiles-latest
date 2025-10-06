-- ~/.config/nvim/lua/config/icon_picker.lua
local fzf = require 'fzf-lua'

-- A small list (you can expand this with emojis, Nerd Font icons, etc.)
local icons = {
  '🔥',
  '⚡',
  '✅',
  '☑',
  '❌',
  '⭐',
  '📌',
  '💡',
  '🚀',
  '📝',
  '🔗',
  '🎉',
}

local function pick_icon()
  fzf.fzf_exec(icons, {
    prompt = ' Icons> ',
    actions = {
      ['default'] = function(selected)
        vim.api.nvim_put(selected, 'c', true, true)
      end,
    },
  })
end

vim.keymap.set('n', '<leader>pi', pick_icon, { desc = 'Insert icon' })
vim.keymap.set('i', '<C-i>', pick_icon, { desc = 'Insert icon (insert mode)' })
