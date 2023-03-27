return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {
        config = {
          folds = false,
          icon_preset = "diamond",
        },
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            --tasks = "~/Google\\ Drive/My\\ Drive/Shared/Neorg/tasks",
            tasks = "~/.config/neorg/tasks/",
            --wildcard = "~/Google\\ Drive/My\\ Drive/Shared/Neorg/wildcard",
            wildcard = "~/.config/neorg/wildcard/",
            -- holstee = "~/Google\\ Drive/My\\ Drive/Shared/Neorg/holstee",
            holstee = "~/.config/neorg/holstee/",
            --personal = "~/Google\\ Drive/My\\ Drive/Shared/Neorg/personal",
            personal = "~/.config/neorg/personal/",
          },
          default_workspace = "tasks",
          index = "index.norg",
        },
      },
    },
  },
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
