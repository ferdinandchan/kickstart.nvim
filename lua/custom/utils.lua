local M = {}
---@param repo string
---@return string
function M.gh(repo) return 'https://github.com/' .. repo end

-- Install Mason packages that are not installed yet. For language files in
-- `custom/plugins/`, which load after init.lua's mason-tool-installer list
-- has already been handed over.
---@param names string[] Mason package names, as shown in `:Mason`
function M.mason_install(names)
  local registry = require 'mason-registry'
  registry.refresh(function()
    for _, name in ipairs(names) do
      local ok, pkg = pcall(registry.get_package, name)
      if not ok then
        vim.notify(('mason: unknown package %s'):format(name), vim.log.levels.WARN)
      elseif not pkg:is_installed() and not pkg:is_installing() then
        vim.notify(('mason: installing %s'):format(name))
        pkg:install()
      end
    end
  end)
end

return M
