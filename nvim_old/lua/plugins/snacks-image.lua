return {
  'folke/snacks.nvim',
  lazy = false, -- Load on startup to show dashboard
  priority = 1000, -- Load early
  opts = {
    --    styles = {
    --    snacks_image = {
    --        relative = 'editor',
    --        col = -1,
    --      },
    --    },
    image = {
      enabled = true,
      backend = 'kitty', -- ← Changed from "magick" to "kitty"
      doc = {
        inline = false,
        float = true,
        only_render_image_at_cursor = true, -- Only show when cursor on image line
        max_width = 60,
        max_height = 30,
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':FzfLua files' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ':FzfLua live_grep' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':FzfLua oldfiles' },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })",
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = ' ', key = '<esc>', desc = 'Quit', action = ':qa' },
        },
        -- Font Name: ANSI Shadow
        -- https://patorjk.com/software/taag
        header = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
      },
    },
  },
}
