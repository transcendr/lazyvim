return {
  "mikesoylu/ai.vim",
  dependencies = "copilot.lua",
  opts = {},
  config = function(_, opts)
    local nvim_notify = require("notify")
    nvim_notify.notify("Mikesoylu AI config is running", "INFO", {})
  end,
}
