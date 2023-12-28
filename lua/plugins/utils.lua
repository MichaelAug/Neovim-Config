-- Small utility plugins
return {

  -- Auto tabstop and shiftwidth detect
  {'tpope/vim-sleuth'},

  -- Indent hints
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
}
