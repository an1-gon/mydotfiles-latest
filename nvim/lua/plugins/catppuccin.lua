return {
  "catppuccin/nvim",
  name = "catppuccin", 
    lazy = false,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    integrations = {
      auto_integrations = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
    
    -- Force additional transparency if needed
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Ensure everything stays transparent even after colorscheme changes
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
      end,
    })
  end,
}
