local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end


local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "%.pdf",
      ".git/",
      ".*/ckeditor.js",
      ".DS_Store"
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-p>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
        ["<C-p>"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
    },
  },
  pickers = {
    buffers = {
      initial_mode = "normal",
    }
  }
})

telescope.load_extension("fzf")
telescope.load_extension("dap")

