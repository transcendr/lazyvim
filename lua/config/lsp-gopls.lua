local ih = require("inlay-hints")
return {

  -- add gopls to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- gopls will be automatically installed with mason and loaded with lspconfig
        gopls = {
          on_attach = function(c, b)
            vim.notify("gopls attached with inlay-hints!")
            ih.on_attach(c, b)
          end,
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
          cmd = { "goopts" },
          filetypes = { "go", "gomod", "gowork", "gotmpi" },
        },
      },
    },
  },
}

-- ispconfig.gopts.setup {
-- on_attach = on_attach,
-- capabilities = capabilities,
-- cmd = {"gopts"},
-- filetypes = { "go", "gomod", "gowork",
-- "gotmpi" }
-- root_dir = util.root_pattern("go.work"
-- "go.mod",
-- ".git"),
