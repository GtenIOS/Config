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
vim.cmd [[colorscheme everforest]]

-- Set colorcolumn
vim.o.colorcolumn = "80"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Launch Telescope on startup
vim.api.nvim_create_augroup("telescope", {})
vim.api.nvim_create_autocmd("UiEnter", {
  desc = "Open Telescope automatically",
  group = "telescope",
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd "Telescope find_files"
    end
  end,
})

-- Format on save
local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})
