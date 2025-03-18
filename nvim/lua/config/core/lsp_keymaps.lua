local opts = { noremap = true, silent = true }
return function(_, bufnr)
  opts.buffer = bufnr

  opts.desc = "Show references"
  vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>", opts)

  opts.desc = "Go to declaration"
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

  opts.desc = "Show definitions"
  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)

  opts.desc = "Show implementations"
  vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)

  opts.desc = "Show type definitions"
  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_definitions<cr>", opts)

  opts.desc = "Code actions"
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

  opts.desc = "Smart rename"
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  opts.desc = "File diagnostics"
  vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

  opts.desc = "Line diagnostics"
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

  opts.desc = "Previous diagnostic"
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

  opts.desc = "Next diagnostic"
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

  opts.desc = "Show documentation"
  vim.keymap.set("n", "<C-,>", vim.lsp.buf.hover, opts)

  opts.desc = "Restart LSP"
  vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<cr>", opts)
end
