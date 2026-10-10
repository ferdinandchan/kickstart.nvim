local M = {}
---@param repo string
---@return string
function M.gh(repo) return 'https://github.com/' .. repo end

-- Tools for mason-tool-installer to install: lspconfig server names or Mason
-- package names. init.lua adds its servers, language files in
-- `custom/plugins/` add theirs, and init.lua hands the list over once they
-- have all loaded.
---@type string[]
M.mason_tools = {}

return M
