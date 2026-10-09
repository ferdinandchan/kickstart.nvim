-- import the GH helper
local utils = require 'custom.utils'
local gh = utils.gh

--
-- Python
--
-- basedpyright (types, hover, go-to) is set up in init.lua SECTION 6. ruff
-- runs beside it for linting, fixes and formatting. Tests: neotest-python,
-- in zz-neotest.lua.
vim.list_extend(utils.mason_tools, { 'ruff', 'debugpy' })

vim.lsp.config('ruff', {
  -- leave hover to basedpyright, so K doesn't show two popups
  on_init = function(client) client.server_capabilities.hoverProvider = false end,
})
vim.lsp.enable 'ruff'

require('conform').formatters_by_ft.python = { 'ruff_organize_imports', 'ruff_format' }

--
-- Debugging, using Mason's debugpy. Picks up the project's .venv when run
-- from its root.
--
vim.pack.add { gh 'mfussenegger/nvim-dap-python' }
require('dap-python').setup(vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python')
