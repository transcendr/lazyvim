return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ue",
      function()
        require("edgy").toggle()
      end,
      desc = "Edgy Toggle",
    },
    -- stylua: ignore
    { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
  },
  opts = function()
    local opts = {
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "noice",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "lazyterm",
          title = "",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- don't open help files in edgy that we're editing
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
        { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
      },
      -- left = {
      --   {
      --     title = "File Explorer",
      --     ft = "neo-tree",
      --     filter = function(buf)
      --       return vim.b[buf].neo_tree_source == "filesystem"
      --     end,
      --     pinned = true,
      --     open = function()
      --       vim.api.nvim_input("<esc><space>e")
      --     end,
      --     size = { height = 0.5 },
      --   },
      --   { title = "Test UI", ft = "neotest-summary" },
      --   {
      --     title = "Git Exploer",
      --     ft = "neo-tree",
      --     filter = function(buf)
      --       return vim.b[buf].neo_tree_source == "git_status"
      --     end,
      --     pinned = true,
      --     open = "Neotree position=right git_status",
      --   },
      --   {
      --     title = "Buffers",
      --     ft = "neo-tree",
      --     filter = function(buf)
      --       return vim.b[buf].neo_tree_source == "buffers"
      --     end,
      --     pinned = true,
      --     open = "Neotree position=top buffers",
      --   },
      --   "neo-tree",
      -- },
      keys = {
        -- increase width
        ["<C-S-Right>"] = function(win)
          win:resize("width", 2)
        end,
        -- decrease width
        ["<c-S-Left>"] = function(win)
          win:resize("width", -2)
        end,
        -- increase height
        ["<C-S-Up>"] = function(win)
          win:resize("height", 2)
        end,
        -- decrease height
        ["<C-S-Down>"] = function(win)
          win:resize("height", -2)
        end,
      },
    }
    local Util = require("lazyvim.util")
    if Util.has("symbols-outline.nvim") then
      table.insert(opts.left, {
        title = "Outline",
        ft = "Outline",
        pinned = true,
        open = "SymbolsOutline",
      })
    end
    return opts
  end,
}
