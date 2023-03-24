-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.functions")
require("config.lazy")
require("flutter-tools").setup({
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = false,
    run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
    -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
    -- see |:help dap.set_exception_breakpoints()| for more info
    exception_breakpoints = {},
    register_configurations = function(paths)
      require("dap").configurations.dart = {
        {
          type = "dart",
          name = "Dev Mobile",
          request = "launch",
          program = "lib/main.dart",
          args = {
            "--flavor",
            "dev",
            "--dart-define=DEV_BUILD=true",
          },
        },
      }
    end,
  },
}) -- use defaults

-- NVR
if vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
end
