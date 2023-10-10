local packer_bootstrap = false

local config = {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

local function packer_init()
    local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        packer_bootstrap = vim.fn.system {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        }

        vim.cmd [[packadd packer.nvim]]
    end

    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
end

local function plugins(use)
    use { "wbthomason/packer.nvim" }

    use {
        "sainnhe/everforest",
        config = function()
            vim.cmd "colorscheme everforest"
        end,
    }

    use {
        "goolord/alpha-nvim",
        config = function()
            require("config.alpha").setup()
        end,
    }

    use {
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            local status_ok, neogit = pcall(require, "neogit")
            if not status_ok then
                return
            end

            neogit.setup {}
        end,
    }

    use { "lervag/vimtex" }
    use { "sirver/ultisnips" }

    if packer_bootstrap then
        print "Restart Neovim required"
        require("packer").sync()
    end
end

packer_init()

local packer = require "packer"
packer.init(config)
packer.startup(plugins)

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

vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.api.nvim_set_keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true, silent = true })

vim.g['vimtex_view_general_viewer'] = 'zathura'
vim.g['vimtex_quickfix_mode'] = 0
vim.g['vimtex_syntax_enabled'] = 1
vim.g['tex_conceal'] = 'abdmg'

vim.g['UltiSnipsSnippetDirectories'] = { '~/.config/nvim/UltiSnips' }
vim.g['UltiSnipsExpandTrigger'] = '<tab>'
vim.g['UltiSnipsJumpForwardTrigger'] = '<tab>'
vim.g['UltiSnipsJumpBackwardTrigger'] = '<s-tab>'
