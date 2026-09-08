--
-- Flutter and Dart
--

-- import the GH helper
local gh = require('custom.utils').gh

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
  flutter_path = vim.fn.expand '~/sdks/flutter/bin/flutter',
  widget_guides = { enabled = true },
  closing_tags = { enabled = true, highlight = 'Comment', prefix = '// ' },
  dev_log = { enabled = true, open_cmd = 'tabedit' },
  lsp = {
    color = { enabled = true, background = true },
    settings = {
      showTodos = true,
      renameFilesWithClasses = 'prompt',
      updateImportsOnRename = true,
    },
  },
}
