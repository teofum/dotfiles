return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "mrcjkb/rustaceanvim", version = "^5", lazy = false },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
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
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<cr>", opts)
    end

    -- Rustaceanvim doesn't need setup, but we still set the keymaps:
    vim.g.rustaceanvim = {
      server = {
        on_attach = on_attach,
      },
    }

    local capabilities = cmp_nvim_lsp.default_capabilities()

    lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })
    lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })
    lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
    lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })

    -- Special settings for Lua lang server: make it recognize vim globals and runtime
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig.clangd.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        fallback_flags = { "--std=c++20" }, -- If no config is present, assume C++ 20
      },
    })
  end,
}
