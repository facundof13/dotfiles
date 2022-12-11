local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_respect_buf_cwd = 1

nvimtree.setup({
  open_on_setup = true,
  git = {
    ignore = false,
  },
  update_cwd = true,
  updated_focused_file = {
    enable = true,
    update_cwd = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})

