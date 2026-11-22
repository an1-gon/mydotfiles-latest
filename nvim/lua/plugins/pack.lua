vim.pack.add({
'https://github.com/nvim-mini/mini.nvim',
'https://github.com/rebelot/kanagawa.nvim',
'https://github.com/catppuccin/nvim',
'https://github.com/L3MON4D3/LuaSnip',
{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', branch = 'main'},
'https://github.com/neovim/nvim-lspconfig',
'https://github.com/mason-org/mason.nvim',
'https://github.com/meanderingprogrammer/render-markdown.nvim',
'https://github.com/bullets-vim/bullets.vim',
})

--** Configure ColorScheme **--
require("catppuccin").setup({
    transparent_background = true,

    -- Makes floating windows (e.g. LSP hover, diagnostics) transparent
      float = {
        transparent = true,
        solid = false,
      },

      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        native_lsp = {
          enabled = true,
          inlay_hints = {
            background = false, -- Transparent inlay hints background
          },
        },
      },
})

--** Set the ColorScheme **--
vim.cmd.colorscheme("catppuccin")

--** Mini Files **--

-- Enable plugin after installing in pack add
require('mini.files').setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out= "_",
        go_out_plus= "H",
    },
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- opens minifiles in normal mode using -
vim.keymap.set("n", "<leader>-", function()

    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file"})

--** Mini Notify **--
require('mini.notify').setup({
    --only show messages
    content = {
        format = function(notify)
            return notify.msg
        end,

    },
})


--** Mini Cmdline Completions**--

require('mini.cmdline').setup({
    autocorrect = { enable = false }
})

--** Mini File Picker**--
require('mini.pick').setup({})

vim.keymap.set("n", "<leader>mf", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>ms", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>")}) end, { desc = "Mini Fuzzy Word Search" })
vim.keymap.set("n", "<leader>mb", function() MiniPick.builtin.buffers() end, { desc = "Mini Buffer" })
vim.keymap.set("n", "<leader>mh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })

--** Mini Extras **--
require('mini.extra').setup({})

vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Diagnostic" })
vim.keymap.set("n", "<leader>mk", function() MiniExtra.pickers.keymaps() end, { desc = "Search Keymaps" })


--** Mini Completions**--
local MiniCompletion = require("mini.completion")
MiniCompletion.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return MiniCompletion.default_process_items(items, base, {
                filter = "fuzzy",
            })
        end,
    }

})



--** LuaSnip **--
local ls = require("luasnip")

require("luasnip.loaders.from_lua").lazy_load({

    paths = {
        vim.fn.stdpath("config") .. "/lua/luasnippets",
    }

})

ls.setup({
    history = true,
    enable_autosnippets = false,
})


vim.keymap.set({"i", "s"}, "<C-k>", function()
    if ls.expand_or_jumpable() then
    ls.expand_or_jump()
    end

end, { silent = true } )

vim.keymap.set({"i", "s"}, "<C-j>", function()
    if ls.jumpable(-1) then
    ls.jump(-1)
    end

end, { silent = true } )

--** Enable Treesitter **--
require("nvim-treesitter")

--** Enable Lsp **--
require("plugins.lsp")
