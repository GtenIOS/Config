-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Telescope
vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>", { silent = true })
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<Leader>F", ":Telescope git_files<CR>", { silent = true })
vim.keymap.set("n", "<Leader>s", ":Telescope symbols<CR>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<S-Up>", "<C-w><Up>", { silent = true })
vim.keymap.set("n", "<S-Left>", "<C-w><Left>", { silent = true })
vim.keymap.set("n", "<S-Right>", "<C-w><Right>", { silent = true })
vim.keymap.set("n", "<S-Down>", "<C-w><Down>", { silent = true })

-- Misc keymaps
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "jj", "<Esc> <CR>", { silent = true })
-- vim.keymap.set("n", "<C-t>", ":call FloatingWindowTerm() <CR> A", { silent = true })
vim.keymap.set("n", "<C-t>", ":FloatermToggle<CR>", { silent = true })
vim.keymap.set("n", "<C-e>", ":Vex <CR>", { silent = true })

-- Comment keymaps
vim.keymap.set("n", "<C-c>", "<Plug>(comment_toggle_linewise_current)", { silent = true })
vim.keymap.set("i", "<C-c>", "<Esc> <Plug>(comment_toggle_linewise_current) i", { silent = true })
vim.keymap.set("v", "<C-c>", "<Plug>(comment_toggle_linewise_visual)", { silent = true })

-- Neo-tree
vim.keymap.set("n", "<C-n>", ":Neotree<CR>")


