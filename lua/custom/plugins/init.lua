-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Iterate over all Lua files in the plugins directory and load them

-- local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
--
-- local modules = {}
-- for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
--   if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
--     local module = file_name:gsub('%.lua$', '')
--     require('custom.plugins.' .. module)
--   end
-- end

local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')

local modules = {}
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then table.insert(modules, (file_name:gsub('%.lua$', ''))) end
end
table.sort(modules) -- deterministic; prefix files `10-`, `20-` to control order

for _, module in ipairs(modules) do
  local ok, err = pcall(require, 'custom.plugins.' .. module)
  if not ok then vim.notify(('custom.plugins.%s failed:\n%s'):format(module, err), vim.log.levels.ERROR) end
end
