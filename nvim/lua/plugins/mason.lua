return
{
'mason-org/mason.nvim',

        opts = {
            "harper-ls",
            "html-lsp",
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,

    }
