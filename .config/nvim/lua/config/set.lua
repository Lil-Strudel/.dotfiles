-- Makes space the leader
vim.g.mapleader = " "

-- Makes the cursor a block always
vim.opt.guicursor = "a:block"

-- Enables line numbers
vim.opt.nu = true

-- Makes line numbers relative
vim.opt.relativenumber = true

-- Makes tab with 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Replaces tabs with spaces
vim.opt.expandtab = true

-- Automatically indents
vim.opt.smartindent = true

-- Disable line wrapping
vim.opt.wrap = false

-- Disables swap and backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Enables and configures undofile
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Shows search as you're typing
vim.opt.incsearch = true

-- Removes highlight after search
vim.opt.hlsearch = false

-- Enables true color support
vim.opt.termguicolors = true

-- Buts a dark line on the 80th character
vim.opt.colorcolumn = "80"

-- Highlights the line the cursor is on
vim.opt.cursorline = true

-- Shorten the wait for the CursorHold event
vim.opt.updatetime = 50

-- Leaves 8 lines above/below cursor while scrolling
vim.opt.scrolloff = 8

-- Makes the sign column always visable
vim.opt.signcolumn = "yes"

-- I have no idea tbh
vim.opt.isfname:append("@-@")

-- Configure username in instant.nvim
vim.g.instant_username = "lilstrudel"
