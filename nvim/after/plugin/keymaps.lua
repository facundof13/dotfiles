local keymap = vim.api.nvim_set_keymap
local default_ops = {noremap = true, silent = true}

vim.g.mapleader = " "

-- general keymaps
keymap("n", "<leader>/", ":nohl<CR>", default_ops)
keymap("n", "J", "5j", default_ops)
keymap("n", "K", "5k", default_ops)
keymap("n", "<leader>j", "J", default_ops)
keymap("n", "<C-u>", "<C-u>zz", default_ops)
keymap("n", "<C-d>", "<C-d>zz", default_ops)

-- window management
keymap("n", "<leader>sv", "<C-w>v", default_ops) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", default_ops) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", default_ops) -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>", default_ops) -- close current split window

keymap("n", "<leader>to", ":tabnew<CR>", default_ops) -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>", default_ops) -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>", default_ops) --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>", default_ops) --  go to previous tab

-- plugin keymaps

-- vim-maximizer
keymap("n", "<leader>sm", ":MaximizerToggle<CR>", default_ops)

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", default_ops)

-- telescope
keymap("n", "<leader>p", "<cmd>Telescope find_files hidden=true<cr>", default_ops) -- find files within current working directory, respects .gitignore
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", default_ops) -- find string in current working directory as you type
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", default_ops) -- find string under cursor in current working directory
keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>", default_ops) -- list open buffers in current neovim instance
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", default_ops) -- list available help tags
keymap("n", "<leader>ff", "<cmd>Telescope current_buffer_fuzzy_find fuzzy=false<cr>", default_ops) -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", default_ops) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", default_ops) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", default_ops) -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", default_ops) -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap("n", "<leader>rs", ":LspRestart<CR>", default_ops) -- mapping to restart lsp if necessary

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_ops)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_ops)
keymap("n", "<Up>", ":resize -1<CR>", default_ops)
keymap("n", "<Down>", ":resize +1<CR>", default_ops)

-- Better indent
keymap("v", "<", "<gv", default_ops)
keymap("v", ">", ">gv", default_ops)


-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_ops)
keymap("n", "<S-l>", ":bnext<CR>", default_ops)

keymap("n", "n", "nzz", default_ops);
keymap("n", "N", "Nzz", default_ops);
keymap("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", default_ops)


-- -- Tmux
-- keymap("n", "<A-h>", "<Cmd>NavigatorLeft<CR>", default_ops)
-- keymap("n", "<A-j>", "<Cmd>NavigatorDown<CR>", default_ops)
-- keymap("n", "<A-k>", "<Cmd>NavigatorUp<CR>", default_ops)
-- keymap("n", "<A-l>", "<Cmd>NavigatorRight<CR>", default_ops)
-- keymap("n", "<A-\\>", "<Cmd>NavigatorPrevious<CR>", default_ops)

-- Debug
keymap('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>',default_ops)
keymap('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>',default_ops)
keymap('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>',default_ops)
keymap('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>',default_ops)
keymap('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>',default_ops)

keymap('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>',default_ops)
keymap('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>',default_ops)
keymap('v', '<leader>dhv',
          '<cmd>lua require"dap.ui.variables".visual_hover()<CR>',default_ops)

keymap('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>',default_ops)
keymap('n', '<leader>duf',
          "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",default_ops)

keymap('n', '<leader>dsbr',
          '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',default_ops)
keymap('n', '<leader>dsbm',
          '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',default_ops)
keymap('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>',default_ops)
keymap('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>',default_ops)


-- telescope-dap
keymap('n', '<leader>dcc',
          '<cmd>lua require"telescope".extensions.dap.commands{}<CR>',default_ops)
keymap('n', '<leader>dco',
          '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>',default_ops)
keymap('n', '<leader>dlb',
          '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>',default_ops)
keymap('n', '<leader>dv',
          '<cmd>lua require"telescope".extensions.dap.variables{}<CR>',default_ops)
keymap('n', '<leader>df','<cmd>lua require"telescope".extensions.dap.frames{}<CR>',default_ops)

-- switch buffer
keymap('n', '<C-s>','<cmd>SwitchBuffer<CR>',default_ops)

-- del buffer
keymap('n','<leader>x','<cmd>bdel<cr>',default_ops)
