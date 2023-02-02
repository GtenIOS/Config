require('package_manager')
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('lazy').setup('plugins')

-- Floating terminal
require('terminal')

require('misc')

require('keymaps')

require('highlight')

require('plugin_config')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

