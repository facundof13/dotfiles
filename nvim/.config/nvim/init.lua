-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.camelcasemotion_key = "<leader>"
vim.keymap.set("n", "<leader>/", ":noh<CR>")

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable true color support
vim.opt.termguicolors = true

-- Setup lazy.nvim
require("lazy").setup({
	-- PLUGINS GO HERE
	spec = {
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000
		},
		{
			"kylechui/nvim-surround",
			version = "^3.0.0",
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({})
			end,
		},
		{ "https://github.com/ggandor/leap.nvim" },
		{ "https://github.com/bkad/CamelCaseMotion" },
		{ "https://github.com/tpope/vim-repeat" },
		{
			"numToStr/Comment.nvim",
			opts = {},
			config = function()
				require("Comment").setup()
			end,
		},
		{
			"https://github.com/monaqa/dial.nvim",
			config = function()
				local augend = require("dial.augend")
				require("dial.config").augends:register_group({
					default = {
						augend.integer.alias.decimal,
						augend.integer.alias.hex,
						augend.constant.alias.bool,
						augend.date.alias["%Y/%m/%d"],
						augend.constant.new({
							elements = { "&&", "||" },
							word = false,
							cyclic = true,
						}),
						augend.constant.new({
							elements = { "===", "!==" },
							word = false,
							cyclic = true,
						}),
					},
				})
			end,
		},
		{
			'nvim-treesitter/nvim-treesitter',
			build = ':TSUpdate',
			cond = not vim.g.vscode,
			opts = {
				ensure_installed = { 'lua', 'typescript', 'javascript', 'tsx', 'json', 'html', 'css' },
				highlight = { enable = true },
				indent = { enable = true },
			},
		},
		{
			'nvim-telescope/telescope.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			cond = not vim.g.vscode,
			config = function()
				local actions = require('telescope.actions')
				require('telescope').setup({
					defaults = {
						mappings = {
							i = {
								["<C-q>"] = actions.send_selected_to_qflist +
								    actions.open_qflist,
							},
							n = {
								["<C-q>"] = actions.send_selected_to_qflist +
								    actions.open_qflist,
							},
						},
					},
				})
			end,
		},
		{ 'https://github.com/lewis6991/gitsigns.nvim' },
		{ "https://github.com/ibhagwan/fzf-lua" },
		{
			'williamboman/mason.nvim',
			cond = not vim.g.vscode,
			config = true,
		},
		{
			'williamboman/mason-lspconfig.nvim',
			cond = not vim.g.vscode,
			dependencies = { 'williamboman/mason.nvim' },
			config = function()
				require('mason-lspconfig').setup({
					ensure_installed = { 'ts_ls', 'lua_ls' },
				})
			end,
		},
		{
			'hrsh7th/nvim-cmp',
			cond = not vim.g.vscode,
			dependencies = {
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-path',
			},
			config = function()
				local cmp = require('cmp')
				cmp.setup({
					mapping = cmp.mapping.preset.insert({
						['<C-Space>'] = cmp.mapping.complete(),
						['<CR>'] = cmp.mapping.confirm({ select = true }),
						['<Tab>'] = cmp.mapping.select_next_item(),
						['<S-Tab>'] = cmp.mapping.select_prev_item(),
						['<C-e>'] = cmp.mapping.abort(),
					}),
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'buffer' },
						{ name = 'path' },
					}),
				})
			end,
		},
		{
			'neovim/nvim-lspconfig',
			cond = not vim.g.vscode,
			dependencies = { 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
			config = function()
				local capabilities = require('cmp_nvim_lsp').default_capabilities()
				vim.lsp.config('ts_ls', { capabilities = capabilities })
				vim.lsp.enable('ts_ls')

				vim.api.nvim_create_autocmd('LspAttach', {
					callback = function(args)
						local opts = { buffer = args.buf }
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
						vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
						vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
						vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
					end,
				})
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			cond = not vim.g.vscode,
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require('treesitter-context').setup({
					enable = true,
					max_lines = 5,
				})
				vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom',
					{ underline = true, sp = 'Grey' })
			end,
		},
		{
			'stevearc/conform.nvim',
			cond = not vim.g.vscode,
			config = function()
				require('conform').setup({
					formatters_by_ft = {
						javascript = { 'prettier' },
						typescript = { 'prettier' },
						typescriptreact = { 'prettier' },
						javascriptreact = { 'prettier' },
						json = { 'prettier' },
						html = { 'prettier' },
						css = { 'prettier' },
					},
					format_on_save = {
						timeout_ms = 500,
						lsp_fallback = true,
					},
				})
			end,
		},
		{
			"nvim-tree/nvim-web-devicons",
			opts = {},
			cond = not vim.g.vscode
		},
		{
			"christoomey/vim-tmux-navigator",
			lazy = false,
			cmd = {
				"TmuxNavigateLeft",
				"TmuxNavigateDown",
				"TmuxNavigateUp",
				"TmuxNavigateRight",
				"TmuxNavigatePrevious",
				"TmuxNavigatorProcessList",
			},
			keys = {
				{ "<C-h>",  "<cmd>TmuxNavigateLeft<cr>" },
				{ "<C-j>",  "<cmd>TmuxNavigateDown<cr>" },
				{ "<C-k>",  "<cmd>TmuxNavigateUp<cr>" },
				{ "<C-l>",  "<cmd>TmuxNavigateRight<cr>" },
				{ "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
			},
			cond = not vim.g.vscode
		},
		{
			'nvim-lualine/lualine.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				require('lualine').setup()
			end
		}
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
	end,
})

vim.opt.clipboard:append("unnamedplus")
-- Dial.nvim (modify numbers, dates, booleans with cyclic patterns)
vim.keymap.set("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
	require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "g<C-a>", function()
	require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "g<C-x>", function()
	require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("x", "<C-a>", function()
	require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("x", "<C-x>", function()
	require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("x", "g<C-a>", function()
	require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("x", "g<C-x>", function()
	require("dial.map").manipulate("decrement", "gvisual")
end)

-- telescope
vim.keymap.set('n', '<leader>ft', ':Telescope<CR>')
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>')
vim.keymap.set('n', '<leader>fr', ':Telescope resume<CR>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>o', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document symbols' })

-- diagnostic
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previos diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })

-- Leap.nvim (jump to any character)
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-anywhere)")
vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
vim.opt.gdefault = true

-- rename symbol
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })


vim.opt.number = true
vim.opt.relativenumber = true

-- Disable automatic comment continuation
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- copy filename
vim.keymap.set('n', '<leader>cf', function()
	vim.fn.setreg('+', vim.fn.expand('%:t'))
	print('Copied: ' .. vim.fn.expand('%:t'))
end, { desc = 'Copy filename' })
vim.keymap.set('n', '<leader>cp', function()
	vim.fn.setreg('+', vim.fn.expand('%'))
	print('Copied relative path: ' .. vim.fn.expand('%'))
end, { desc = 'Copy relative path' })

vim.opt.autoread = true
vim.cmd.colorscheme "catppuccin"

vim.keymap.set("n", "<leader>en", function()
	print("hello world")
end, { desc = "Edit Neovim config" })
