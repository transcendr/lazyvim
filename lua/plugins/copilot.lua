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
    panel = { -- no config options yet
      enabled = true,
    },
    -- Enable the suggestion feature.
    -- This is a feature that allows you to cycle through the suggestions
    suggestion = {
      -- Should the suggestion feature be enabled?
      enabled = true,
      -- Should the suggestion be triggered automatically?
      auto_trigger = true,
      -- The amount of time in milliseconds to wait before triggering the suggestion.
      debounce = 75,
      -- Setup the keymap for the suggestion feature.
      keymap = {
        -- Conflicts with Zellij for some reason
        --accept = "<S-CR>",
        accept = "<CR><CR>",
        next = "<C-]>",
        prev = "<C-[>",
        dismiss = "<C-o>",
      },
    },
    -- suggestion = { enabled = false },
    -- panel = { enabled = false },
  },
}
