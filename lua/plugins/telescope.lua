-- Fuzzy finder 
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Grep files in current dir' })
      vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Buffers' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Files' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = 'Recent files' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Commands' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
    end
  },

  -- Menu dialog UI extension
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
