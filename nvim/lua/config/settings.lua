vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.syntax = "on"
vim.opt.updatetime = 300
vim.opt.encoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- Autocorrect previous misspelled word
vim.api.nvim_set_keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true, silent = true })

-- Show trailing whitespace
vim.cmd([[
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
]])

-- Strip trailing whitespace
vim.cmd([[
    fun! StripTrailingWhitespace()
        " Only strip if the b:noStripeWhitespace variable isn't set
        if exists('b:noStripWhitespace')
            return
        endif
        %s/\s\+$//e
    endfun
    autocmd BufWritePre * call StripTrailingWhitespace()
]])

-- Highlight on yank
vim.cmd([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]])
