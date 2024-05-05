local M = {
  'mbbill/undotree',
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[u]ndotree' }),
}

return M
