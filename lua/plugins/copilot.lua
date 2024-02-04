-- This plugin is a wrapper around the Copilot plugin for nvim-cmp.
-- It configures special options for Lazy.nvim.
--
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    cmp = {
      -- Enables the nvim-cmp for Copilot.
      enabled = true,
      method = "getCompletionsCycling",
    },
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "right", -- | top | left | right
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        -- accept the suggestion
        accept = "kk",
        -- accept the next word only
        accept_word = "ww",
        -- accept the next line only
        accept_line = "ll",
        -- cycle to the next suggestion
        next = "<C-]>",
        -- cycle to the previous suggestion
        prev = "<C-[>",
        -- dismiss the suggestion
        dismiss = "<C-o>",
      },
      -- panel = { -- no config options yet
      --   enabled = true,
      -- },
      -- -- Enable the suggestion feature.
      -- -- This is a feature that allows you to cycle through the suggestions
      -- suggestion = {
      --   -- Should the suggestion feature be enabled?
      --   enabled = true,
      --   -- Should the suggestion be triggered automatically?
      --   auto_trigger = true,
      --   -- The amount of time in milliseconds to wait before triggering the suggestion.
      --   debounce = 75,
      --   -- Setup the keymap for the suggestion feature.
      --   keymap = {
      --     -- Conflicts with Zellij for some reason
      --     --accept = "<S-CR>",
      --     --accept = "<CR><CR>",
      --     accept = "ll",
      --     next = "<C-]>",
      --     prev = "<C-[>",
      --     dismiss = "<C-o>",
      --   },
    },
    -- suggestion = { enabled = false },
    -- panel = { enabled = false },
  },
}
