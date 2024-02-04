return {
  -- {{{ Define the Harpoon lazy.vim specificaiton.

  "ThePrimeagen/harpoon",
  enabled = true,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ Define events to load Harpoon.
  keys = function()
    local harpoon = require("harpoon")
    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end
      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    return {
      -- Harpoon marked files 1 through 4
      {
        "<leader>j",
        function()
          harpoon:list():select(1)
        end,
        desc = "Harpoon buffer 1",
      },
      {
        "<leader>k",
        function()
          harpoon:list():select(2)
        end,
        desc = "Harpoon buffer 2",
      },
      {
        "<leader>l",
        function()
          harpoon:list():select(3)
        end,
        desc = "Harpoon buffer 3",
      },
      {
        "<leader>;",
        function()
          harpoon:list():select(4)
        end,
        desc = "Harpoon buffer 4",
      },
      {
        "<leader>,j",
        function()
          harpoon:list():select(5)
        end,
        desc = "Harpoon buffer 5",
      },
      {
        "<leader>,k",
        function()
          harpoon:list():select(6)
        end,
        desc = "Harpoon buffer 6",
      },
      {
        "<leader>,l",
        function()
          harpoon:list():select(7)
        end,
        desc = "Harpoon buffer 7",
      },
      {
        "<leader>,;",
        function()
          harpoon:list():select(8)
        end,
        desc = "Harpoon buffer 8",
      },
      -- Harpoon next and previous.
      {
        "<leader>n",
        function()
          harpoon:list():next()
        end,
        desc = "Harpoon next buffer",
      },
      {
        "<leader>",
        function()
          harpoon:list():prev()
        end,
        desc = "Harpoon prev buffer",
      },

      -- Harpoon user interface.
      {
        "<leader>h",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Toggle Menu",
      },
      {
        "<leader>m",
        function()
          harpoon:list():append()
        end,
        desc = "Harpoon add file",
      },

      -- Use Telescope as Harpoon user interface.
      {
        "<leader>th",
        function()
          toggle_telescope(harpoon:list())
        end,
        desc = "Open Harpoon window",
      },
    }
  end,

  -- ----------------------------------------------------------------------- }}}
  -- {{{ Use Harpoon defaults or my customizations.

  opts = function(_, opts)
    opts.settings = {
      save_on_toggle = false,
      sync_on_ui_close = false,
      save_on_change = true,
      enter_on_sendcmd = false,
      tmux_autoclose_windows = false,
      excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
      mark_branch = false,
      key = function()
        return vim.loop.cwd()
      end,
    }
  end,

  -- ----------------------------------------------------------------------- }}}
  -- {{{ Configure Harpoon.

  config = function(_, opts)
    require("harpoon").setup(opts)
  end,

  -- ----------------------------------------------------------------------- }}}
}
