-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.hidden = true
opt.joinspaces = false
opt.clipboard = "unnamedplus"
opt.wildmode = "full"
opt.gdefault = true
opt.autoread = true
opt.ruler = true
opt.cursorline = true
opt.cursorlineopt = "both"
opt.ttimeoutlen = 1
vim.g.lazyvim_picker = "telescope"
