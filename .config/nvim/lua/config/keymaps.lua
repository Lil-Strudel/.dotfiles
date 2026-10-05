local map = vim.keymap.set

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>d", [["_d]])

map("n", "Q", "<nop>")

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map("n", "gl", function() vim.diagnostic.open_float({ scope = "line", focus = false }) end)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)

for key, dir in pairs({ h = "L", j = "D", k = "U", l = "R" }) do
    map("n", "<C-" .. key .. ">", function()
        local win = vim.api.nvim_get_current_win()
        vim.cmd.wincmd(key)
        if vim.env.TMUX and win == vim.api.nvim_get_current_win() then
            vim.system({ "tmux", "select-pane", "-t", vim.env.TMUX_PANE, "-" .. dir })
        end
    end)
end
