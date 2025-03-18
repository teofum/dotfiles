return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "mrcjkb/rustaceanvim", version = "^5", lazy = false },
    "mfussenegger/nvim-jdtls",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local on_attach = require("config.core.lsp_keymaps")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Rustaceanvim doesn't need setup, but we still set the keymaps:
    vim.g.rustaceanvim = {
      server = {
        on_attach = on_attach,
      },
    }

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
