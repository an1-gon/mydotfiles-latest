local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
  "Popup Window",
  "This is a floating buffer",
  "Press q to close",
})

local width = 40
local height = 10
local opts = {
  style = "minimal",
  relative = "editor",
  width = width,
  height = height,
  row = (vim.o.lines - height) / 2,
  col = (vim.o.columns - width) / 2,
  border = "rounded"
}

local win = vim.api.nvim_open_win(buf, true, opts)

vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })

