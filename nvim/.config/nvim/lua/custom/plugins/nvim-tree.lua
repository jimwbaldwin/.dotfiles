local function my_on_attach()
  -- disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- enable 24-bit colour
  vim.opt.termguicolors = true
end

local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'NvimTreeToggle',
  config = function(_, opts)
    require('nvim-tree').setup(opts)
  end,
  opts = {
    -- on_attach = my_on_attach,
    filters = {
      dotfiles = false,
      custom = {
        '^\\.git$',
        '^\\.ruff_cache$',
      },
    },
  },
}

return M
