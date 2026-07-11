-- SET LEADER
vim.g.mapleader = ' '

-- --------------------------------------------------------------------------------------------------
-- KEYBINDS
-- --------------------------------------------------------------------------------------------------
-- FILE MANAGEMENT & NAVIGATION
-- --------------------------------------------------------------------------------------------------
-- [Write]
vim.keymap.set('n', '<leader>w', ':w<CR>', {noremap = true}) --Save [leader][w] Normal Mode
-- [Quit]
vim.keymap.set('n', '<leader><BS>', ':q<CR>', {noremap = true}) --Quit [leader][backspace] Normal Mode
vim.keymap.set('n', '<leader>q', ':q<CR>', {noremap = true}) --Quit [leader][q] Normal Mode
-- [Treeview]
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true}) -- Toggle Treeview [leader][e] Normal Mode
-- [Escape]
vim.keymap.set({'n','v','i'}, '<leader>jj', '<ESC>', {noremap = true}) -- Escape [leader][j][j] Normal Mode
-- [ENTER]
vim.keymap.set({'n','v','i'}, '<leader>hh', '<CR>', {noremap = true}) -- Enter [leader][h][h] Normal Mode





	

-- -------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------
-- IN FILE NAVIGATION
-- -------------------------------------------------------------------------------------------------
-- [GOTO START,END LINE NAVIGATION]
vim.keymap.set({'n','v'}, '<S-h>', '^', {noremap = true}) -- Goto first non empty character on Line [SHIFT][H]
vim.keymap.set({'n','v'}, '<S-l>', '$', {noremap = true}) -- Goto last non empty character on Line [SHIFT][$]

--==================================================================================================
-- [Unbind Arrow Keys]
vim.keymap.set({'n','v','i'}, '<left>', '<Nop>', {noremap = true}) -- Left Normal Mode
vim.keymap.set({'n','v','i'}, '<right>', '<Nop>', {noremap = true}, {noremap = true}) -- right Insert Mode
vim.keymap.set({'n','v','i'}, '<up>', '<Nop>', {noremap = true}) -- up Insert Mode
vim.keymap.set({'n','v','i'}, '<down>', '<Nop>', {noremap = true}) -- down Insert Mode

-- [Unbind Esc Insert Mode]
vim.keymap.set('i', '<ESC>', '<Nop>', {noremap = true}) -- down Insert Mode

-- [Word Count]
vim.keymap.set('n','<leader>wc', ':w !wc -w<CR>', {noremap = true})
