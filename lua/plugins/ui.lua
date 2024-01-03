-- Plugins that change the UI
return {
  -- Indent hints
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function ()
      require("ibl").setup({
        exclude = {
          filetypes = {
            'lspinfo',
            'packer',
            'checkhealth',
            'help',
            'man',
            'dashboard',
            ''
          }
        }
      })
    end
  },

  -- Search highlight
  {
    'kevinhwang91/nvim-hlslens',
    event = "VeryLazy",
  },

  -- Scrollbar
  {
    'petertriho/nvim-scrollbar',

    event = "VeryLazy",
    config = function ()
      require("scrollbar").setup({
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true, -- Requires gitsigns
          handle = true,
          search = true, -- Requires hlslens
        }
      })
    end
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = 'tokyonight'
      }
    },
  },

  -- Buffer (tab) view
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<leader>bd", "<Cmd>:bdelete<CR>", desc = "Delete buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local errorIcon = " "
          local warningIcon  = " "
          local ret = (diag.error and errorIcon .. diag.error .. " " or "")
          .. (diag.warning and warningIcon .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            ---@diagnostic disable-next-line: undefined-global
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  }
}
