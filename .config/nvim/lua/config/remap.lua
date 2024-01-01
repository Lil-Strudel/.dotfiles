-- Moves selected lines up and down with indentation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Centers the cursor after a <C-d/u> jump
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Centers the cursor after going to the next match
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yanks into the system clipboard register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Pastes without overwriting the default register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Deletes without overwriting the default register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Removes that stupid popup window that shows up when you press q: instead of :q
-- vim.api.nvim_set_keymap('n', 'q:', '<nop>', { noremap = true, silent = true }) -- Makes q automap lag
vim.api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true, silent = true })

-- Find and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
