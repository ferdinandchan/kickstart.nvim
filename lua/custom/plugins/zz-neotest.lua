-- Central Neotest config.
-- Named `zz-` so it loads AFTER rust.lua/flutter.lua/typescript.lua and their
-- plugins (rustaceanvim, flutter-tools, neotest-vitest) are on the runtimepath.

local gh = require('custom.utils').gh

vim.pack.add {
  gh 'nvim-neotest/nvim-nio',
  gh 'antoinemadec/FixCursorHold.nvim',
  gh 'nvim-neotest/neotest',
  gh 'sidlatau/neotest-dart',
  gh 'nvim-neotest/neotest-python',
}
vim.g.cursorhold_updatetime = 100

local adapters = {
  require 'neotest-dart' {
    command = 'flutter',
    use_lsp = true,
  },
  require 'neotest-python' {
    runner = 'pytest', -- or 'unittest'
  },
}

-- rustaceanvim ships its own adapter; add it only if that plugin loaded
local ok_rust, rust_adapter = pcall(require, 'rustaceanvim.neotest')
if ok_rust then
  table.insert(adapters, rust_adapter)
else
  vim.notify('neotest: rustaceanvim not loaded, Rust tests disabled', vim.log.levels.WARN)
end

-- neotest-vitest is added by typescript.lua
local ok_vitest, vitest_adapter = pcall(require, 'neotest-vitest')
if ok_vitest then
  table.insert(adapters, vitest_adapter)
else
  vim.notify('neotest: neotest-vitest not loaded, TypeScript tests disabled', vim.log.levels.WARN)
end

require('neotest').setup {
  adapters = adapters,
  quickfix = { enabled = false },
  icons = { running = '󰄉', passed = '', failed = '', skipped = '󰙦' },
}

-- Keymaps, active in buffers these adapters support
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('neotest-keymaps', { clear = true }),
  pattern = { 'dart', 'rust', 'python', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function(ev)
    local nt = require 'neotest'
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    map('<leader>Tt', function() nt.run.run() end,                       'Test: nearest')
    map('<leader>Tf', function() nt.run.run(vim.fn.expand '%') end,      'Test: file')
    map('<leader>Ta', function() nt.run.run(vim.uv.cwd()) end,           'Test: all (cwd)')
    map('<leader>Tl', function() nt.run.run_last() end,                  'Test: last')
    map('<leader>TS', function() nt.run.stop() end,                      'Test: stop')
    map('<leader>Ts', function() nt.summary.toggle() end,                'Test: summary panel')
    map('<leader>To', function() nt.output.open { enter = true } end,    'Test: output float')
    map('<leader>TO', function() nt.output_panel.toggle() end,           'Test: output panel')
    map('<leader>Td', function() nt.run.run { strategy = 'dap' } end,    'Test: debug nearest')
    map(']t',         function() nt.jump.next { status = 'failed' } end, 'Test: next failed')
    map('[t',         function() nt.jump.prev { status = 'failed' } end, 'Test: prev failed')

    local ok, wk = pcall(require, 'which-key')
    if ok then wk.add { { '<leader>T', group = 'Test', buffer = ev.buf } } end
  end,
})
