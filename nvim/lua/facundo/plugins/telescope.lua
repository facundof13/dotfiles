local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end


local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

local config_setup, telescope_config = pcall(require, "telescope.config")
if not config_setup then
  return
end

local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
table.insert(vimgrep_arguments, "-u")
table.insert(vimgrep_arguments, "--no-ignore-vcs")

telescope.setup({
  defaults = {
    vimgrep_arguments = vimgrep_arguments,
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "-u", "--no-ignore-vcs"},
      },
      current_buffer_fuzzy_find = {
      },
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-p>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close
      }
    }
  }
})

telescope.load_extension("fzf")

