return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- Enable LSP integration for better documentation
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- Configure cmdline to use popup view
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- This is key for centering!
      },
      -- Views configuration (moved inside opts)
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          size = { width = 60, height = "auto" },
          border = { style = "rounded" },
        },
      },
      -- Simple presets for common functionality
      presets = {
        bottom_search = false,         -- Classic bottom cmdline for search
        command_palette = true,        -- Position cmdline and popupmenu together
        long_message_to_split = true,  -- Send long messages to a split
      },
    },
    dependencies = {
      -- Required
      "MunifTanjim/nui.nvim",
      -- Recommended for notifications
      {
          "rcarriga/nvim-notify",
            opts = {},
        config = function(_, opts)
             require("noice").setup(opts)

          -- Setup notify with transparency 
        local notify = require("notify")
        notify.setup({
           background_colour = "#000000",
        })
         vim.notify = notify

    -- Clear notify highlights for transparency
      for _, severity in ipairs({ "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }) do
        vim.api.nvim_set_hl(0, "Notify" .. severity .. "Border", { bg = "none" })
        vim.api.nvim_set_hl(0, "Notify" .. severity .. "Body",   { bg = "none" })
        vim.api.nvim_set_hl(0, "Notify" .. severity .. "Title",  { bg = "none" })
      end
        vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "none" })
      end,

      },    
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
      },
    }
  }
}
