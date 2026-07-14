-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>t", function() end, { desc = "Terminal" })

vim.keymap.set("n", "<leader>tf", function()
  require("toggleterm").toggle(nil, nil, nil, "float")
end, { desc = "Open a floating terminal" })

vim.keymap.set("n", "<leader>th", function()
  require("toggleterm").toggle(nil, nil, nil, "horizontal")
end, { desc = "Open an horizontal terminal" })

vim.keymap.set("n", "<leader>tv", function()
  require("toggleterm").toggle(nil, nil, nil, "vertical")
end, { desc = "Open a vertical terminal" })

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>tg",
  "<cmd>lua _lazygit_toggle()<CR>",
  { noremap = true, silent = true, desc = "Open a floating terminal with LazyGit" }
)
