local M = {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-neotest/neotest-python',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('neotest').setup {
      adapters = { require 'neotest-python' { runner = 'pytest' } },
      --     keys = {
      --       {
      --         '<leader>nt',
      --         function()
      --           require('neotest').summary.open()
      --           vim.cmd [[Neotest run]]
      --           -- require('neotest').run.run(vim.fn.expand('%'))
      --         end,
      --         desc = 'Neotest toggle',
      --       },
      --       {
      --         '<leader>np',
      --         function()
      --           require('neotest').output_panel.toggle()
      --         end,
      --         desc = 'Neotest output_panel toggle',
      --       },
      --     },
    }
  end,
}

return {}
