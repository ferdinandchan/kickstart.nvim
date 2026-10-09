--
-- Flutter and Dart
--

-- import the GH helper
local utils = require 'custom.utils'
local gh = utils.gh

-- Dart debug adapter, kept in the Mason tool list
vim.list_extend(utils.mason_tools, { 'dart-debug-adapter' })

-- Flutter icons
vim.pack.add { gh 'folke/snacks.nvim' }
vim.pack.add { gh 'sidlatau/flutter-icons.nvim' }
-- snacks: the image module must be enabled
require('snacks').setup { image = { enabled = true } }

require('flutter-icons').setup {
  builtin_icons = true, -- also render Icons.* (not just Symbols.*)
  -- color = nil,            -- "#rrggbb"; nil follows the Normal fg
  -- png_size = 64,          -- source PNG px (display is one text row)
  -- virtual_text = true,    -- auto-enable inline icons in Dart source
}

-- register the completion-doc provider with blink
require('blink.cmp').setup {
  sources = {
    transform_items = require('flutter-icons').transform_items,
  },
}

--
-- Flutter tools
--
vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'stevearc/dressing.nvim', -- optional for vim.ui.select
  gh 'nvim-flutter/flutter-tools.nvim',
}

require('flutter-tools').setup {
  widget_guides = { enabled = true },
  closing_tags = { enabled = true, highlight = 'Comment', prefix = '// ' },
  dev_log = { enabled = true, open_cmd = 'tabedit' },
  lsp = {
    settings = {
      showTodos = true,
      renameFilesWithClasses = 'prompt',
      updateImportsOnRename = true,
    },
  },
}

-- Neovim 0.12 handles document colors natively; flutter-tools' `lsp.color` is deprecated
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('flutter-document-color', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'dartls' then vim.lsp.document_color.enable(true, { bufnr = args.buf }) end
  end,
})

-- Register <leader>F to trigger flutter-tools
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('flutter-keymaps', { clear = true }),
  pattern = 'dart',
  callback = function(ev)
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map('<leader>Fr', '<cmd>FlutterRun<cr>',           'Flutter: run')
    map('<leader>Fq', '<cmd>FlutterQuit<cr>',          'Flutter: quit')
    map('<leader>Fh', '<cmd>FlutterReload<cr>',        'Flutter: hot reload')
    map('<leader>FR', '<cmd>FlutterRestart<cr>',       'Flutter: hot restart')
    map('<leader>Fd', '<cmd>FlutterDevices<cr>',       'Flutter: devices')
    map('<leader>Fe', '<cmd>FlutterEmulators<cr>',     'Flutter: emulators')
    map('<leader>Fo', '<cmd>FlutterOutlineToggle<cr>', 'Flutter: outline')
    map('<leader>FD', '<cmd>FlutterDevTools<cr>',      'Flutter: DevTools')
    map('<leader>Fl', '<cmd>FlutterLogClear<cr>',      'Flutter: clear log')
    map('<leader>FL', '<cmd>FlutterLspRestart<cr>',    'Flutter: restart LSP')

    -- special map that allow us to run flutter with web server inside devbox
    map('<leader>FW', '<cmd>FlutterRun -d web-server --web-hostname=0.0.0.0 --web-port=8080<cr>', 'Flutter: run (web-server)')

    -- buffer-local which-key group label (safe if which-key isn't loaded)
    local ok, wk = pcall(require, 'which-key')
    if ok then wk.add { { '<leader>F', group = 'Flutter', buffer = ev.buf } } end
  end,
})
