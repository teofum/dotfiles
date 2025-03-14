return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("Comment").setup()

        -- Keybinds
        vim.keymap.set({"n", "i"}, "<C-/>", "<Plug>(comment_toggle_linewise_current)")
        vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)")
    end
}
