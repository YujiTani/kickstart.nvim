return {
  -- add gruvbox
  { 'ellisonleao/gruvbox.nvim' },

  -- Configure LazyVim to load gruvbox
  {
    --    'LazyVim/LazyVim',
    --    opts = {
    --      colorscheme = 'gruvbox',
    --    },
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { style = 'moon' },
  },
}
