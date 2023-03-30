-- local Split = require("nui.split")
-- local event = require("nui.utils.autocmd").event

-- local split = Split({
--   relative = "editor",
--   position = "right",
--   size = "50%",
-- })

-- -- mount/open the component
-- split:mount()

-- -- unmount component when cursor leaves buffer
-- split:on(event.BufLeave, function()
--   split:unmount()
-- end)

local function open_selected_or_yanked_text_in_vsplit()
  -- Get the selected text or the most recently yanked text
  local start_line, end_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
  local selected_text = vim.fn.getline(start_line, end_line)

  -- Open a new vertical split
  vim.cmd("vnew")

  -- Set the buffer filetype to TypeScript
  vim.cmd("set filetype=typescript")

  -- Enable wrap
  vim.cmd("set wrap")

  -- Insert the selected or yanked text into the new buffer
  if selected_text == "" then
    vim.fn.append(0, selected_text)
  else
    -- paste the text
    vim.cmd("normal! p")
    --vim.cmd("1delete")
  end

  -- Now select all text in the new buffer
  vim.cmd("normal ggVG")
end

local function ToggleAIModel()
  if vim.g.ai_model == "gpt-3.5-turbo" then
    vim.g.ai_model = "gpt-4"
    vim.notify("AI model set to gpt-4", "INFO", {})
  else
    vim.g.ai_model = "gpt-3.5-turbo"
    vim.notify("AI model set to gpt-3.5-turbo", "INFO", {})
  end
end

vim.api.nvim_create_user_command("AIToggleModel", ToggleAIModel, { nargs = 0 })

local function SetAIContext()
  local context = vim.fn.input("Context: ")
  vim.g.ai_context_before = context
  vim.g.ai_context_after = context
  vim.notify("AI context set to " .. context .. " equally", "INFO", {})
end

vim.api.nvim_create_user_command("AISetContext", SetAIContext, { nargs = 0 })

local function SetAIContextI()
  local context_before = vim.fn.input("Context before: ")
  local context_after = vim.fn.input("Context after: ")
  vim.g.ai_context_before = context_before
  vim.g.ai_context_after = context_after
  vim.notify("AI context set to " .. context_before .. " before and " .. context_after .. " after", "INFO", {})
end

vim.api.nvim_create_user_command("AISetContextI", SetAIContextI, { nargs = 0 })

-- Function that: if the current buffer has text, deletes all text in the buffer, but if the current buffer has no text, deletes the current buffer and closes the window
local function delete_buffer_if_empty()
  local line_count = vim.fn.line("$")
  if line_count == 1 and vim.fn.getline(1) == "" then
    vim.cmd("bd!")
  else
    -- switch to normal mode
    vim.cmd("normal! gg")
    -- delete all text in the buffer (including the last line)
    vim.cmd("normal! dG")
    --vim.cmd("normal! 0ggvGVdd")
  end
end

-- Opens a terminal in the directory of the current file in a new tab
-- local function open_terminal_in_file_dir()
--   -- Get the current file's directory
--   local file_dir = vim.fn.expand("%:p:h")
--   -- Open a new vertical split
--   vim.cmd("vnew")
--   -- compatible with zsh shell version:
--   vim.cmd("term zsh -c 'cd " .. file_dir .. "; zsh'")
-- end

-- Opens a terminal in the directory of the current file in a new tab
local function open_terminal_in_file_dir()
  -- Get the current file's directory
  local file_dir = vim.fn.expand("%:p:h")
  -- Open a new vertical split
  vim.cmd("vnew")
  -- Set the working directory for the new terminal buffer
  vim.cmd("tcd " .. file_dir)
  -- compatible with zsh shell version:
  vim.cmd("term zsh")
end

vim.api.nvim_create_user_command("OpenTerminalInFileDir", open_terminal_in_file_dir, { nargs = 0 })

return {
  open_selected_text_in_vsplit = open_selected_or_yanked_text_in_vsplit,
  toggle_ai_model = ToggleAIModel,
  set_ai_context = SetAIContext,
  set_ai_context_i = SetAIContextI,
  delete_buffer_if_empty = delete_buffer_if_empty,
  open_terminal_in_file_dir = open_terminal_in_file_dir,
}
