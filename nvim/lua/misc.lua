-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make relative line numbers default
vim.o.rnu = true
vim.o.number = true

-- Tab/Spacing config
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme gruber]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


