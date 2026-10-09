-- import the GH helper
local utils = require 'custom.utils'
local gh = utils.gh

--
-- TypeScript / JavaScript
--
-- LSP: vtsls (a wrapper around VS Code's TypeScript extension). Formatting:
-- prettierd, or the project's own prettier. Tests: neotest-vitest, registered
-- in zz-neotest.lua. TypeScript itself comes from the project's node_modules.
utils.mason_install { 'vtsls', 'prettierd' }

vim.lsp.enable 'vtsls'

local prettier = { 'prettierd', 'prettier', stop_after_first = true }
local formatters_by_ft = require('conform').formatters_by_ft
formatters_by_ft.typescript = prettier
formatters_by_ft.typescriptreact = prettier
formatters_by_ft.javascript = prettier
formatters_by_ft.javascriptreact = prettier
formatters_by_ft.json = prettier

require('nvim-treesitter').install { 'typescript', 'tsx', 'javascript', 'json' }

vim.pack.add { gh 'marilari88/neotest-vitest' }
