return {
  "leoluz/nvim-dap-go",
  lazy = true,
  -- load when a go file is opened
  ft = { "go" },
  -- wait until nvim-dap is loaded
  dependencies = "mfussenegger/nvim-dap",
  -- trigger a nvim-notify message when loaded
  config = function(_, opts)
    require("dap-go").setup(opts)
    vim.notify("Loaded nvim-dap-go", vim.log.levels.INFO, {
      title = "nvim-dap-go",
    })
  end,
  -- opts = function(_, opts)
  --   opts.mapping = vim.tbl_extend("force", opts.mapping, require("config.dap-go-mappings").dap_go)
  -- end,
}
