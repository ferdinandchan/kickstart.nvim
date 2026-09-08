-- import the GH helper
local gh = require('custom.utils').gh

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

-- Version info and completion inside `Cargo.toml`
vim.pack.add { gh 'Saecki/crates.nvim' }
require('crates').setup {
  completion = { crates = { enabled = true } },
}
