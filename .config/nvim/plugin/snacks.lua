require("snacks").setup({
    bigfile = { enabled = true },
    indent = { enabled = true },
    picker = { enabled = true },
})

local picker = require("snacks").picker
vim.keymap.set("n", "<leader>pf", picker.files)
vim.keymap.set("n", "<C-p>", picker.git_files)
vim.keymap.set("n", "<leader>ps", picker.grep)
