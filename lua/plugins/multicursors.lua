return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "smoka7/hydra.nvim",
  },
  opts = function()
    local N = require("multicursors.normal_mode")
    local I = require("multicursors.insert_mode")
    return {
      normal_keys = {
        -- to change default lhs of key mapping change the key
        ["b"] = {
          -- assigning nil to methods exits from multi cursor mode
          methods = N.clear_others,
          -- description to show in hint window
          desc = "Clear others",
        },
      },
      insert_keys = {
        -- to change default lhs of key mapping change the key
        ["<CR>"] = {
          -- assigning nil to methods exits from multi cursor mode
          methods = I.Cr_method,
          -- description to show in hint window
          desc = "new line",
        },
      },
    }
  end,
  keys = {
    {
      "<Leader>m",
      "<cmd>MCstart<cr>",
      desc = "Create a selection for word under the cursor",
    },
  },
}
