-- Java LS
local home_dir = os.getenv("HOME")
local homebrew_prefix = os.getenv("HOMEBREW_PREFIX")
local root_dir = require("jdtls.setup").find_root({ "mvnw", "gradlew", ".git" })
local jdtls_ver = "1.45.0"
local workspace_folder = home_dir .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local on_attach = require("config.core.lsp_keymaps")

require("jdtls").start_or_attach({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = root_dir,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      -- contentProvider = { preferred = "fernflower" },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    vim.fn.glob(
      homebrew_prefix .. "/Cellar/jdtls/" .. jdtls_ver .. "/libexec/plugins/org.eclipse.equinox.launcher_*.jar"
    ),

    "-configuration",
    homebrew_prefix .. "/Cellar/jdtls/" .. jdtls_ver .. "/libexec/config_mac",

    "-data",
    workspace_folder,
  },
})
