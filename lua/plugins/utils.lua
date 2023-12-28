-- Small utility plugins
return {

  -- Auto tabstop and shiftwidth detect
  {'tpope/vim-sleuth'},

  -- Indent hints
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
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

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
}
