-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- tab navigation
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- buffer
keymap.set("n", "<leader>bp", ":bprev<CR>") --  go to buffer previous
keymap.set("n", "<leader>bn", ":bnext<CR>") --  go to buffer next

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- git signs
keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>") -- goto next hunk
keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<CR>") -- goto prev hunk
keymap.set("n", "<leader>gv", ":Gitsigns preview_hunk<CR>") -- preview hunk
keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>") -- line blame
