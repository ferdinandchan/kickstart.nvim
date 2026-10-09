-- import the GH helper
local utils = require 'custom.utils'

--
-- Kotlin
--
-- LSP: JetBrains' kotlin-lsp, which runs on the JDK in JAVA_HOME. It imports
-- Gradle projects itself, so open nvim from the directory with
-- settings.gradle.kts. Formatting: ktlint. No neotest adapter; run
-- `./gradlew test` instead.
utils.mason_install { 'kotlin-lsp', 'ktlint' }

vim.lsp.enable 'kotlin_lsp'

require('conform').formatters_by_ft.kotlin = { 'ktlint' }

require('nvim-treesitter').install { 'kotlin' }
