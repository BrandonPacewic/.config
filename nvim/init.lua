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

    -- Session manager
    use { "Shatur/neovim-session-manager" }

    -- Command menu
    use { "folke/which-key.nvim" }

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

vim.opt.updatetime = 50

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

-- Session manager settings
local Path = require("plenary.path")

require("session_manager").setup({
  sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
  path_replacer = "__",
  colon_replacer = "++",
  autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
  autosave_last_session = true,
  autosave_ignore_not_normal = true,
  autosave_ignore_dirs = {},
  autosave_ignore_filetypes = {
    "gitcommit",
  },
  autosave_ignore_buftypes = {},
  autosave_only_in_session = true,
  max_path_length = 80,
})

-- Command menu settings
which_key = require("which-key")
which_key.setup {
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
    popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
    },
    window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = "auto",
    triggers_blacklist = {
        n = { "q", "w", "h", "j", "k", "l", "s", "t", "v", "x", "z" },
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    ["b"] = { "<cmd>VimtexCompile<CR>", "build" },
    ["v"] = { "<cmd>VimtexView<CR>", "view" },
    s = {
        name = "Manage Sessions",
        s = { "<cmd>SessionManager save_current_session<CR>", "save" },
        d = { "<cmd>SessionManager delete_session<CR>", "delete" },
        l = { "<cmd>SessionManager load_session<CR>", "load" },
    }
}

which_key.register(mappings, opts)
