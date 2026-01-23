return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
      dim_inactive = true,
      contrast = "hard",
      overrides = {
        NormalNC = { bg = "#1d2021" }, -- inactive pane background (matches tmux)
        -- Flash.nvim highlights
        FlashLabel = { bg = "#8ec07c", fg = "#1d2021", bold = true }, -- aqua bg, dark text
        FlashMatch = { bg = "#fabd2f", fg = "#1d2021" }, -- yellow bg
        FlashCurrent = { bg = "#b8bb26", fg = "#1d2021" }, -- green bg
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = { "filename_first" },
        mappings = {
          i = {
            ["<Esc>"] = require("telescope.actions").close,
          },
          n = {
            ["<Esc>"] = require("telescope.actions").close,
          },
        },
      },
    },
    keys = {
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find Diagnostics" },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
      require("Comment").setup()
    end,
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
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
    cond = not vim.g.vscode,
  },

  {
    "nvim-mini/mini.animate",
    opts = {},
    cond = false,
  },

  {
    "flash.nvim",
    opts = {
      jump = {
        pos = "end", -- jump to end of match
      },
    },
    cond = not vim.g.vscode,
  },

  {
    "folke/snacks.nvim",
    opts = { picker = { sources = { explorer = { hidden = true, ignored = true } } } },
  },

  {
    "lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {}
    end,
  },

  {
    "nvim-lspconfig",
    opts = function(_, opts)
      opts["servers"]["vtsls"] = nil
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
