return {
  -- Automatically add matching brackets
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = function ()
      require('mini.pairs').setup()
    end
  },

  -- Surround text and movement keybinds
  -- press 's' to see help
  {
    'echasnovski/mini.surround',
    version = false,
    config = function ()
      require('mini.surround').setup({})
    end
  },

  -- Extend a/i textobjects
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function ()
      require('mini.ai').setup()
    end
  }
}
