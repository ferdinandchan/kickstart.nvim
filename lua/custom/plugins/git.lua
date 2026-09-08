-- import the GH helper
local gh = require('custom.utils').gh

--
-- diffView - For better git diff viewing
--
vim.pack.add { gh 'sindrets/diffview.nvim' }
require('diffview').setup {}

--
-- diffView - For better git diff viewing
--
vim.pack.add { gh 'NeogitOrg/neogit' }
require('neogit').setup {
  integrations = { diffview = true },
}

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = '[G]it status' })
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = '[G]it [D]iff (working tree)' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = '[G]it file [H]istory' })
vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<CR>', { desc = '[G]it diff [C]lose' })
