-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require "telescope.actions"
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<CR>"] = actions.select_tab,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      follow = true,
      no_ignore = true,
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>", { silent = true })
vim.keymap.set("n", "<Leader>f", function ()
  local git_dir = vim.fn.finddir('.git', vim.fn.getcwd() .. ";")
  if (git_dir ~= "")
  then
    require('telescope.builtin').git_files()
  else
    require('telescope.builtin').find_files()
  end
end, { silent = true })
vim.keymap.set("n", "<Leader>F", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<Leader>s", ":Telescope symbols<CR>", { silent = true })

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]Git [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, { desc = '[G]o to [S]ymbol' })

