-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
vim.keymap.set("n", "<C-n>", ":Neotree toggle=true<CR>")

-- vim-visual-multi
vim.keymap.set("n", "<C-d>", ":call vm#commands#ctrln(1)<CR>", { silent = true })
vim.keymap.set("i", "<C-d>", ":call vm#commands#ctrln(1)<CR>", { silent = true })
vim.keymap.set("n", "<M-C-Down>", ":call vm#commands#add_cursor_down(1, 1)<CR>", { silent = true })
vim.keymap.set("n", "<M-C-Up>", ":call vm#commands#add_cursor_up(1, 1)<CR>", { silent = true })

