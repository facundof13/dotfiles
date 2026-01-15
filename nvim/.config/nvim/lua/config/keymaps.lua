-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

keymap.set("n", "gl", function()
  vim.diagnostic.open_float({ wrap = false })
end, { desc = "Show diagnostic" })
keymap.set("n", "[d", vim.diagnostic.get_prev, { desc = "Previos diagnostic" })
keymap.set("n", "]d", vim.diagnostic.get_next, { desc = "Next Diagnostic" })
local gotoDiagnosticErrors = function()
  require("telescope.builtin").diagnostics({ severity = vim.diagnostic.severity.ERROR })
end
keymap.set("n", "]E", gotoDiagnosticErrors, { desc = "View errors in diagnostic" })
keymap.set("n", "[E", gotoDiagnosticErrors, { desc = "View errors in diagnostic" })
keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap.set("n", "<M-j>", ":cnext<CR>")
keymap.set("n", "<M-k>", ":cprev<CR>")

keymap.set("n", "<leader>cf", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
  print("Copied: " .. vim.fn.expand("%:t"))
end, { desc = "Copy filename" })
keymap.set("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  print("Copied relative path: " .. vim.fn.expand("%"))
end, { desc = "Copy relative path" })

keymap.set("n", "<C-d>", function()
  -- Trigger the scroll
  local keys = vim.api.nvim_replace_termcodes("<C-d>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
  -- Center after animation completes
  require("mini.animate").execute_after("scroll", function()
    vim.cmd("normal! zz")
  end)
end)

keymap.set("n", "<C-u>", function()
  -- Trigger the scroll
  local keys = vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
  -- Center after animation completes
  require("mini.animate").execute_after("scroll", function()
    vim.cmd("normal! zz")
  end)
end)
