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
    vim.cmd("1delete")
  end

  -- Now select all text in the new buffer
  vim.cmd("normal ggVG")
end

return { open_selected_text_in_vsplit = open_selected_or_yanked_text_in_vsplit }
