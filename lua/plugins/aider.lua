return {
  "joshuavial/aider.nvim",

  opts = {
    -- auto_manage_context = false,
    default_bindings = false,
  },

  keys = function()
    return {
      {
        "<leader>ao4t",
        "<cmd>lua AiderOpen('--model=gpt-4-turbo-preview --dark-mode')<cr>i",
        desc = "Aider Open (gpt-4-turbo-preview)",
      },
      {
        "<leader>ao",
        "<cmd>lua AiderOpen('--model=gpt-4-1106-preview --dark-mode')<cr>i",
        desc = "Aider Open (gpt-4-1106-preview)",
      },
      {
        "<leader>ao3",
        "<cmd>lua AiderOpen('--model=gpt-3.5-turbo --dark-mode')<cr>i",
        desc = "Aider Open (gpt-3.5-turbo)",
      },
      {
        "<leader>ab",
        "<cmd>lua AiderBackground('--model=gpt-4-1106-preview')<cr>",
        desc = "Aider Background",
        -- defaults to message "Complete as many todo items as you can and remove the comment for any item you complete."
      },
      {
        "<leader>agc",
        "<cmd>lua AiderBackground('--model=gpt-4-1106-preview --commit')<cr>",
        desc = "[A]ider [G]it [C]ommit (4t, bg)",
        -- generates a commit message for all uncommitted changes and commits them
      },
      -- {
      --   "<leader>acd",
      --   '<cmd>lua AiderBackground("--model=gpt-3.5-turbo", "add documentation comments to all structs, functions, etc that are missing them")<CR>',
      --   desc = "[A]ider [C]omment [D]ocumentation (3.5t, bg)",
      --   -- adds documentation comments to all structs, functions, etc that are missing them on the current buffer
      -- },
    }
  end,
}
