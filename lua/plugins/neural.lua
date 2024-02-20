return {
  -- Alreay installed by lazy.nvim
  -- {
  --   "muniftanjim/nui.nvim",
  -- },
  {
    "elpiloto/significant.nvim",
  },
  {
    "dense-analysis/neural",
    -- dependencies = {
    --   "elpiloto/significant.nvim",
    -- },
    opts = {},
    config = function(_, opts)
      require("neural").setup({
        source = {
          openai = {
            api_key = vim.env.OPENAI_API_KEY,
          },
          chatgpt = {
            api_key = vim.env.OPENAI_API_KEY,
          },
        },
      })
      -- local nvim_notify = require("notify")
      -- nvim_notify.notify("Neural config is running", "INFO", {})
      vim.g.neural.selected = "chatgpt"
    end,
  },
}
