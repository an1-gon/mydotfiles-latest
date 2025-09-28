return
{
  "nvim-treesitter/nvim-treesitter", 
  branch = 'master', 
  lazy = false, 
  build = ":TSUpdate",

  config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "lua", "javascript", "html", "markdown", "css", "json", "bash", "dockerfile", "typescript", "vim", "yaml"
          },
          auto_install = true,
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn", -- set to `false` to disable one of the mappings
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },

      })
    end
}


