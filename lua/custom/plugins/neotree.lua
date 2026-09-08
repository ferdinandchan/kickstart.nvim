--
-- Neo-tree - the file explore sidebar
--

-- import the GH helper
local gh = require('custom.utils').gh

vim.pack.add { gh 'nvim-neo-tree/neo-tree.nvim' }
-- neo-tree requires these dependencies
vim.pack.add { gh 'nvim-lua/plenary.nvim' }
vim.pack.add { gh 'MunifTanjim/nui.nvim' }
vim.pack.add { gh 'nvim-tree/nvim-web-devicons' }

require('neo-tree').setup {
  -- your config here
}

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle [E]xplorer' })
