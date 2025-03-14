return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top" },
          vertical = { prompt_position = "top" },
          flex = { prompt_position = "top" },
        },
        borderchars = {
          prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
      },
    })

    require("telescope").load_extension("fzf")

    vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<C-t>", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<C-g>", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<C-S-g>", "<cmd>Telescope grep_string<cr>")
    vim.keymap.set("n", "<C-S-/>", "<cmd>Telescope help_tags<cr>")
    vim.keymap.set("n", "<C-S-m>", "<cmd>Telescope man_pages<cr>")
  end,
}
