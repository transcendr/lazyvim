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
  if vim.g.ai_model == "gpt-3.5-turbo-16k" then
    vim.g.ai_model = "gpt-4-1106-preview"
    vim.notify("AI model set to gpt-4 turbo", "INFO", {})
  else
    vim.g.ai_model = "gpt-3.5-turbo-16k"
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

function reload_buffer()
  local temp_sync_value = vim.g.aider_buffer_sync
  vim.g.aider_buffer_sync = 0
  vim.api.nvim_exec2("e!", { output = false })
  vim.g.aider_buffer_sync = temp_sync_value
end

vim.api.nvim_create_user_command("ReloadBuffer", reload_buffer, { nargs = 0 })

-- Gets the path of the current file from the current working directory
-- and copies it to the clipboard
local function aider_add_comments_35()
  -- Get the current file's path
  local file_path = vim.fn.expand("%:p")
  -- Remove the current working directory from the path
  file_path = file_path:gsub(vim.fn.getcwd(), "")
  -- Remove the first character from the path (a forward slash)
  file_path = file_path:sub(2)

  -- Copy the path to the clipboard
  vim.fn.setreg("+", file_path)
  -- Notify the user
  vim.notify("" .. file_path, "INFO", {})
  -- Pass the file path to Aider
  require("aider").AiderBackground(
    "--model=gpt-3.5-turbo " .. file_path .. "",
    "add documentation comments to all structs, functions, etc that are missing them"
  )
end

vim.api.nvim_create_user_command("AiderAddComments", aider_add_comments_35, { nargs = 0 })

-- Gets the diagnostics message for the current line and copies it to the clipboard
-- and then passes it to Aider with the prompt "Please fix the following issue: "
-- (and the diagnostics message)
local function aider_fix_diagnostic_line()
  -- Get the diagnostics messages for the current line
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  local diagnostics_message = ""
  -- Concatenate all diagnostic messages into a single string
  for i, diagnostic in ipairs(diagnostics) do
    diagnostics_message = diagnostics_message .. diagnostic.message
    if i < #diagnostics then
      diagnostics_message = diagnostics_message .. "\n" -- Add a newline between messages if there are multiple
    end
  end

  -- Get the diagnostics type (error, warning, info, etc) as a string
  local diagnostics_type = vim.diagnostic.severity[diagnostics[1].severity]

  -- Get the current file and strip away the current working directory
  local file_path = vim.fn.expand("%:p")
  file_path = file_path:gsub(vim.fn.getcwd(), "")
  file_path = file_path:sub(2)

  --- Get the current line number
  local line_number = vim.api.nvim_win_get_cursor(0)[1]

  -- Get what is currently in the a register
  local a_register = vim.fn.getreg("a")

  -- Copy the diagnostics message to the clipboard
  vim.fn.setreg("+", diagnostics_message)

  -- Set the prompt
  local prompt = "Address the following diaognstics issue which starts on line '"
    .. line_number
    .. "' in '"
    .. file_path
    .. ".\nDo not generate ANY additional text/commentary/explanation for humans. this raw response will never be seen by a human."
    .. "\nNever use placeholders, always generate full, complete and concise code. There is no human to fix/complete it, therefore ensure your work is 100% complete: "
    .. "\n'''\n"
    .. diagnostics_type
    .. ": "
    .. diagnostics_message
    .. "\n'''"
  -- from a register
  if a_register ~= "" then
    prompt = prompt .. "\n\n Additional information:\n'''\n" .. a_register .. "\n'''"
  end

  -- excape the diagnostics message
  diagnostics_message = diagnostics_message:gsub("'", "\\'")

  -- Show the user the prompt
  vim.notify(prompt, vim.log.levels.INFO)

  -- Clear out the a register
  vim.fn.setreg("a", "")

  -- Pass the diagnostics message to Aider
  require("aider").AiderBackground("--model=gpt-4-turbo-preview", prompt)
end

vim.api.nvim_create_user_command("AiderFixDiagnosticLine", aider_fix_diagnostic_line, { nargs = 0 })

-- Gets the currently selected text and appends it the the "a" register
-- with the current file path (with cwd stripped away) and the current line number, in the format:
-- ------------------------------------
-- <file_path>:<line_number>
-- ------------------------------------
-- <selected_text>
-- ------------------------------------
-- <new_line>
local function append_selected_text_to_a_register()
  -- Get the current file's path
  local file_path = vim.fn.expand("%:p"):gsub(vim.fn.getcwd(), ""):sub(2)

  -- Get the start and end positions of the selected text
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line, start_col = start_pos[2] + 1, start_pos[3] + 1
  local end_line, end_col = end_pos[2] + 1, end_pos[3] + 1

  -- Correct the end column for empty line selection
  if end_col == 0 then
    end_col = 1
  end

  -- Get the selected text
  local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Adjust the text for partial line selections
  if start_line == end_line then
    selected_lines[1] = string.sub(selected_lines[1], start_col, end_col - 1)
  else
    selected_lines[1] = string.sub(selected_lines[1], start_col)
    selected_lines[#selected_lines] = string.sub(selected_lines[#selected_lines], 1, end_col - 1)
  end

  -- Convert the table of lines into a single string
  local selected_text = table.concat(selected_lines, "\n")

  -- Get and prepare the text for the "a" register
  local a_register = vim.fn.getreg("a")
  local register_text = a_register
    .. "\n------------------------------------\n"
    .. file_path
    .. ":"
    .. start_line
    .. "\n------------------------------------\n"
    .. selected_text
    .. "\n------------------------------------\n"

  -- Append the selected text to the "a" register
  vim.fn.setreg("a", register_text)

  -- Notify with the selected text
  vim.notify(register_text, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("AiderAddContext", append_selected_text_to_a_register, { nargs = 0 })

return {
  open_selected_text_in_vsplit = open_selected_or_yanked_text_in_vsplit,
  toggle_ai_model = ToggleAIModel,
  set_ai_context = SetAIContext,
  set_ai_context_i = SetAIContextI,
  delete_buffer_if_empty = delete_buffer_if_empty,
  open_terminal_in_file_dir = open_terminal_in_file_dir,
  reload_buffers = reload_buffer,
  aider_add_comments_35 = aider_add_comments_35,
  aider_fix_diagnostic_line = aider_fix_diagnostic_line,
  aider_add_context = append_selected_text_to_a_register,
}
