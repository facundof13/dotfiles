local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  respect_buf_cwd = true,
  hijack_unnamed_buffer_when_opening = true,
  ignore_buffer_on_setup = true,
  open_on_setup = true,
  git = {
    ignore = false,
  },
  -- update_cwd = true,
  updated_focused_file = {
    enable = true,
    update_root = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})

