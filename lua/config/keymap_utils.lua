local M = {}

local function bind(op, outer_opts)
  outer_opts = vim.tbl_extend("force", { noremap = true, silent = true }, outer_opts or {})

  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local function is_lazygit_running()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype ~= "terminal" then
    return false
  end
  local job_info = vim.fn.job_info(vim.b[bufnr].terminal_job_id)
  if not job_info then
    return false
  end
  local cmd = job_info.cmd
  local isRunning = cmd and cmd:match("lazygit") ~= nil
  return isRunning
end

M.map = bind("")
M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
--M.tnoremap = bind("t")
--tnoremap except for lazygit windows
M.tnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  if not is_lazygit_running() then
    -- Set the keymap for terminal buffers that are not running lazygit
    vim.api.nvim_set_keymap("t", lhs, rhs, opts)
  else
    -- If lazygit is running, do nothing or handle differently
    vim.api.nvim_buf_set_keymap(0, "t", lhs, rhs, opts)
  end
end

return M
