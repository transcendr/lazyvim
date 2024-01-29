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
  widget_guides = {
    enabled = false,
  },
  dev_tools = {
    autostart = true, -- autostart devtools server if not detected
    auto_open_browser = true, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "50vnew", -- command to use to open the outline buffer
    auto_open = true, -- if true this will open the outline automatically when it is first populated
  },
  -- see the link below for details on each option:
  -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
  settings = {
    showTodos = true,
    completeFunctionCalls = true,
    analysisExcludedFolders = { "packages/" },
    renameFilesWithClasses = "prompt", -- "always"
    enableSnippets = true,
    updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
  },
}) -- use defaults

-- NVR
-- NOTE: You must install nvr-remote for this to work
if vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
end
