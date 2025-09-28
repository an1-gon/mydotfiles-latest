return 
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            float = {
                -- Padding around the floating window
                padding = 2,
                -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                max_width = 0.5,
                max_height = 0.5,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
                get_win_title = nil,
                -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                preview_split = "auto",
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf)
                    return conf
                end,
            },
        },
        config = function(_, opts)
            require("oil").setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "oil",
                callback = function()
                    -- Only Oil float window becomes transparent
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
                end,
            })
        end,
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    }

