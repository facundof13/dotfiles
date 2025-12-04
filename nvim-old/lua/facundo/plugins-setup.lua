local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

--  use("nvim-lua/plenary.nvim")

 -- use("shaunsingh/moonlight.nvim")

  --use("christoomey/vim-tmux-navigator")

  --use("szw/vim-maximizer")

  use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  })

  use("numToStr/Comment.nvim")

--  use("nvim-tree/nvim-tree.lua")

 -- use("kyazdani42/nvim-web-devicons")

  --use("nvim-lualine/lualine.nvim")

  --use({"nvim-telescope/telescope-fzf-native.nvim", run = "make"})
  --use({"nvim-telescope/telescope.nvim", branch = "0.1.x" })

  --use("hrsh7th/nvim-cmp")
  --use("hrsh7th/cmp-buffer")
  --use("hrsh7th/cmp-path")

  --use("L3MON4D3/LuaSnip")
  --use("saadparwaiz1/cmp_luasnip")
  --use("rafamadriz/friendly-snippets")

  --use("williamboman/mason.nvim")
  --use("williamboman/mason-lspconfig.nvim")
  --use("neovim/nvim-lspconfig")
  --use("hrsh7th/cmp-nvim-lsp")
  --use{"glepnir/lspsaga.nvim", branch="main"}
  --use("jose-elias-alvarez/typescript.nvim")
  --use("onsails/lspkind.nvim")
  --use("mfussenegger/nvim-dap")
  --use("nvim-telescope/telescope-dap.nvim")
  --use("jayp0521/mason-nvim-dap.nvim")

  --use("jose-elias-alvarez/null-ls.nvim")
  --use("jayp0521/mason-null-ls.nvim")

  --use("folke/which-key.nvim")

  --use({
    --"nvim-treesitter/nvim-treesitter",
    --run = function()
      --require("nvim-treesitter.install").update({with_sync = true})
    --end,
    --})

  --use("windwp/nvim-autopairs")
  --use("windwp/nvim-ts-autotag")

  --use("petertriho/nvim-scrollbar")
  --use("lewis6991/gitsigns.nvim")

  --use("norcalli/nvim-colorizer.lua")

  --use ("numToStr/Navigator.nvim")

  --use ("Yohannfra/Nvim-Switch-Buffer")

  --use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  --use('mbbill/undotree')
  --use'tpope/vim-fugitive'

  if packer_bootstrap then
    require("packer").sync()
  end
end)
