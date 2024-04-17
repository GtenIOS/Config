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
      local git_dir = vim.fn.finddir('.git', vim.fn.getcwd() .. ";")
      if (git_dir ~= "")
      then
        vim.cmd "Telescope git_files"
      else
        vim.cmd "Telescope find_files"
      end
    end
  end,
})

-- Diagnostics signs
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.cmd [[ 
  sign define DiagnosticSignError text=  linehl= texthl=DiagnosticSignError numhl= 
  sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl= 
  sign define DiagnosticSignInfo text=  linehl= texthl=DiagnosticSignInfo numhl= 
  sign define DiagnosticSignHint text=💡  linehl= texthl=DiagnosticSignHint numhl= 
]]

-- Format on save
local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

