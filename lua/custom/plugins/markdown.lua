-- import the GH helper
local gh = require('custom.utils').gh

--
-- Render Markdown
--
vim.pack.add {
  -- 'https://github.com/nvim-treesitter/nvim-treesitter', -- already added by init.lua
  -- 'https://github.com/nvim-mini/mini.nvim',            -- already added by init.lua -- if you use the mini.nvim suite
  -- 'https://github.com/nvim-mini/mini.icons',        -- if you use standalone mini plugins
  -- 'https://github.com/nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
  gh 'MeanderingProgrammer/render-markdown.nvim',
}
require('render-markdown').setup {} -- only mandatory if you want to set custom options
