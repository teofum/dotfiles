return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        presets = {
            command_palette = true,
        },
        cmdline = {
            format = {
                cmdline = { icon = ":" },
                search_down = { icon = "↓/" },
                search_up = { icon = "↑/" },
                help = { icon = "?" },
                lua = { icon = ">" },
                input = { icon = ">" },
            },
        },
        format = {
            level = {
                icons = {
                    error = "[ERR]",
                    warn = "[warn]",
                    info = "[info]",
                },
            },
        },
        popupmenu = {
            kind_icons = false,
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        {
            "rcarriga/nvim-notify",
            opts = {
               icons = {
                   ERROR = "[ERR]",
                   WARN = "[warn]",
                   INFO = "[info]",
                   DEBUG = "[dbg]",
                   TRACE = "[trace]",
               }, 
               stages = "static",
            },
        }
    }
}
