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
        hidden = true,
        path_display = { "filename_first" },
        mappings = {
          i = {
            ["<Esc>"] = require("telescope.actions").close,
          },
          n = {
            ["<Esc>"] = require("telescope.actions").close,
          },
        },
        layout_strategy = "flex",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
    keys = {
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find Diagnostics" },
      -- Swap ff/fF: lowercase = cwd, uppercase = root
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- Swap sg/sG: lowercase = cwd, uppercase = root
      { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>ft", "<cmd>Telescope<cr>", desc = "Telescope" },
      { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Todo Comments" },
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
    opts = {},
    cond = not vim.g.vscode,
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            win = {
              list = {
                keys = {
                  ["<C-x>"] = { "edit_split", mode = { "n" } },
                },
              },
            },
          },
        },
        actions = {
          edit_hsplit = function(picker)
            picker:action("edit_split")
          end,
        },
        win = {
          input = {
            keys = {
              ["<C-x>"] = { "edit_split", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<C-x>"] = { "edit_split", mode = { "n" } },
            },
          },
        },
      },
    },
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

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts) end,
  },
}
