return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        javascript = { { "prettierd ", "prettier" } },
        typescript = { { "prettierd ", "prettier" } },
        javascriptreact = { { "prettierd ", "prettier" } },
        typescriptreact = { { "prettierd ", "prettier" } },
        html = { { "prettierd ", "prettier" } },
        css = { { "prettierd ", "prettier" } },
        json = { { "prettierd ", "prettier" } },
        yaml = { { "prettierd ", "prettier" } },
        markdown = { { "prettierd ", "prettier" } },
        graphql = { { "prettierd ", "prettier" } },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>ff", function()
      conform.format({
        timeout_ms = 500,
        lsp_format = "fallback",
      })
    end, { desc = "Format file (normal) or selection (visual)" })
  end,
}
