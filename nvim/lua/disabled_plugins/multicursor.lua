return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvimtools/hydra.nvim",
    },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
        {
            mode = { "v", "n" },
            "<Leader>m",
            "<cmd>MCunderCursor<cr>",
            desc = "Create a selection under the cursor",
        },
    },
    config = function()
        local mc = require("multicursors")
        
        local normal_defaults = require("multicursors.config").normal_keys
        local extend_defaults = require("multicursors.config").extend_keys

        mc.setup({
            normal_keys = {
                ['l'] = normal_defaults['j'],
                ['L'] = normal_defaults['J'],
            },
            extend_keys = {
                ['j'] = extend_defaults['h'],
                ['k'] = extend_defaults['k'],
                ['l'] = extend_defaults['j'],
                [';'] = extend_defaults['l'],
            }
        })
    end
}
