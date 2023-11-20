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
    use { "nvim-lua/plenary.nvim" }

    -- Theme
    use {
        "sainnhe/everforest",
        config = function()
            vim.cmd "colorscheme everforest"
        end,
    }

    -- Startup screen
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

    -- Latex
    use { "lervag/vimtex" }
    use { "sirver/ultisnips" }

    -- Telescope / Find files
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-telescope/telescope.nvim" }

    if packer_bootstrap then
        print "Restart Neovim required"
        require("packer").sync()
    end
end

packer_init()

-- Load plugins
local packer = require "packer"
packer.init(config)
packer.startup(plugins)

-- General settings
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

-- Spellcheck
vim.opt.spelllang = "en_us"
vim.opt.spell = true
-- TODO: Make a new keymap for this
-- vim.api.nvim_set_keymap("n", "<leader>ss", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true, silent = true })

-- VimTex settings
vim.g["vimtex_view_general_viewer"] = "zathura"
vim.g["vimtex_quickfix_mode"] = 0
vim.g["vimtex_syntax_enabled"] = 1
vim.g["tex_conceal"] = "abdmg"

-- UltiSnips settings
vim.g["UltiSnipsSnippetDirectories"] = { "~/.config/nvim/UltiSnips" }
vim.g["UltiSnipsExpandTrigger"] = "<tab>"
vim.g["UltiSnipsJumpForwardTrigger"] = "<tab>"
vim.g["UltiSnipsJumpBackwardTrigger"] = "<s-tab>"

-- Telescope settings
require("telescope").setup {
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
    },
}

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
vim.keymap.set("n", "<leader>lg", telescope_builtin.live_grep)
