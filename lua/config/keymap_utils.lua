local M = {}

local function bind(op, outer_opts)
  outer_opts = vim.tbl_extend("force", { noremap = true, silent = true }, outer_opts or {})

  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
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
  if vim.bo.filetype == "lazygit" then
    vim.api.nvim_buf_set_keymap(0, "t", lhs, rhs, opts)
  else
    vim.api.nvim_set_keymap("t", lhs, rhs, opts)
  end
end

return M
