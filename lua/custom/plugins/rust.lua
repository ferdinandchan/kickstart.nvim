-- import the GH helper
local utils = require 'custom.utils'
local gh = utils.gh

--
-- Rust
--
-- NOTE: rustaceanvim configures and starts `rust-analyzer` itself, so do NOT
-- also add `rust_analyzer` to the `servers` table in SECTION 6 -- that would
-- attach two clients to every Rust buffer.
--
-- `rust-analyzer` itself comes from rustup, not Mason, so that it always
-- matches the active toolchain:
--    rustup component add rust-analyzer clippy rust-src
--
-- rustaceanvim has no `setup()`; it reads `vim.g.rustaceanvim`, which must be
-- set before the plugin loads.
vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        checkOnSave = true,
        check = { command = 'clippy' },
        inlayHints = { lifetimeElisionHints = { enable = 'skip_trivial' } },
      },
    },
  },
}
vim.pack.add { { src = gh 'mrcjkb/rustaceanvim', version = vim.version.range '6.*' } }

-- Debugger; rustaceanvim finds it in Mason on its own
vim.list_extend(utils.mason_tools, { 'codelldb' })

-- rustfmt also comes from rustup
require('conform').formatters_by_ft.rust = { 'rustfmt' }

-- Version info and completion inside `Cargo.toml`
vim.pack.add { gh 'Saecki/crates.nvim' }
require('crates').setup {
  completion = { crates = { enabled = true } },
}
