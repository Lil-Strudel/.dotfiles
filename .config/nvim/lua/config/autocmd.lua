-- Stolen from LazyVim/LazyVim by Folke
local function augroup(name)
    return vim.api.nvim_create_augroup('local_' .. name, { clear = true })
end

-- close some filetypes with <q> - Thanks Folke
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('close_with_q'),
    pattern = {
        'PlenaryTestPopup',
        'help',
        'lspinfo',
        'man',
        'notify',
        'qf',
        'spectre_panel',
        'startuptime',
        'tsplayground',
        'checkhealth',
        'fugitive',
        'git',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end
})

-- Highlight on Yank - Thanks Folke
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end
})
