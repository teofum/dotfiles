return {
    "ibhagwan/fzf-lua",
    config = function()
        require("fzf-lua").setup()

        vim.keymap.set("n", "<C-p>", "<cmd>FzfLua files<cr>")
        vim.keymap.set("n", "<C-t>", "<cmd>FzfLua buffers<cr>")
        vim.keymap.set("n", "<C-g>", "<cmd>FzfLua live_grep<cr>")
    end
}
