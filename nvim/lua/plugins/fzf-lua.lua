return {
  "ibhagwan/fzf-lua",
  keys = {
    -- Fuzzy Search in Current Directory
    { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find Files in Current Working Directory" },
    -- Fuzzy Search Buffers
    { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Fuzzy Find Currently Open Buffers" },
    -- Fuzzy Live Grep
    { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Fuzzy Find Files Content" },
    -- Fuzzy Help Tag
    { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Fuzzy Help Tags" },
  },
  opts = {
    winopts = {
      backdrop = false,
      border = "rounded",
      preview = { default = "bat",},
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fzf",
      callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FzfLuaBorder", { bg = "NONE" })
-- Preview window specific
        vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", { bg = "NONE" })
      end,
    })
  end,
}

