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

    vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print "Restart NeoVim required."
    return
end

packer.init({
    display = {
        compact = false,
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
        show_all_info = true,
    },
    autoremove = true,
})

packer.startup(function(use)
    use { "wbthomason/packer.nvim" }
    use { "nvim-lua/plenary.nvim" }

    -- Theme
    -- use { "sainnhe/everforest" }
    use { "navarasu/onedark.nvim" }

    -- Latex
    use { "lervag/vimtex" }
    use { "sirver/ultisnips" }

    -- Telescope
    use { "nvim-telescope/telescope.nvim" }
    use { "nvim-treesitter/nvim-treesitter" }

    -- Session Manager
    use { "Shatur/neovim-session-manager" }

    -- Command Menu
    use { "folke/which-key.nvim" }

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- General settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8 
vim.opt.scroll = 20
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.conceallevel = 0
vim.opt.concealcursor = "niv"

vim.opt.syntax = "on"
vim.opt.synmaxcol = 300
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.colorcolumn = "120"
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spellsuggest = "best"

vim.opt.scrolljump = 1
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.icon = true
vim.opt.iconstring = ""

vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"
vim.opt.mousetime = 500

vim.opt.showcmd = true
vim.opt.showmode = true -- Could change for lualine
vim.opt.ruler = true
vim.opt.rulerformat = "%l,%v  %P"
vim.opt.report = 3
vim.opt.verbose = 1
vim.opt.more = true
vim.opt.confirm = true
vim.opt.errorbells = true
vim.opt.visualbell = false
vim.opt.helplang = "en"

vim.opt.selection = "exclusive"
vim.opt.selectmode = "mouse,key"
vim.opt.keymodel = "startsel,stopsel"

vim.opt.undolevels = 1000
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undoreload = 10000
vim.opt.wrapmargin = 1
vim.opt.backspace = "indent,eol,start"
vim.opt.complete = ".,w,b,u,t,i"
vim.opt.matchtime = 2
vim.opt.matchpairs = "(:),{:},[:],<:>"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = false
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.lisp = false

vim.opt.foldenable = false

vim.opt.diff = false
vim.opt.diffopt = "internal,filler,closeoff"

vim.opt.maxmapdepth = 1000
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 50

vim.opt.modeline = true
vim.opt.modelineexpr = true
vim.opt.modelines = 5
vim.opt.binary = false
vim.opt.endofline = true
vim.opt.endoffile = true
vim.opt.fixendofline = false
vim.opt.bomb = false
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos,mac"
vim.opt.write = true
vim.opt.writebackup = true
vim.opt.backup = true
vim.opt.backupcopy = "auto"
vim.opt.backupdir = os.getenv("HOME") .. "/.local/share/nvim/backup"
vim.opt.autowrite = false
vim.opt.autowriteall = false
vim.opt.writeany = false
vim.opt.autoread = true
vim.opt.fsync = true

vim.opt.directory = os.getenv("HOME") .. "/.local/share/nvim/swap"
vim.opt.swapfile = true
vim.opt.updatecount = 100
vim.opt.updatetime = 300

vim.opt.history = 1000
vim.opt.fileignorecase = true
vim.opt.wildignorecase = true
vim.opt.wildmenu = true

vim.opt.shell = "/bin/zsh"
vim.opt.warn = true

vim.opt.isfname = "@,48-57,/,.,-,_,+,,,#,$,%,~,="
vim.opt.isident = "@,48-57,_,192-255"
vim.opt.iskeyword = "@,48-57,_,192-255"
vim.opt.isprint = "@,48-57,_,192-255"
vim.opt.rightleft = false
vim.opt.revins = false
vim.opt.allowrevins = true
vim.opt.aleph = 0
vim.opt.arabic = false
vim.opt.langremap = true

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.emoji = true

vim.opt.signcolumn = "yes"

vim.g.mapleader = " "

-- Themes
local onedark = require("onedark")
onedark.setup({ style = "warmer" })
onedark.load()

-- vim.cmd("colorscheme everforest")

-- Session manager
local Path = require("plenary.path")
require("Session_manager").setup({
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

-- Telescope
require("telescope").setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
    },
})

-- Snippet settings
vim.g["UltiSnipsSnippetDirectories"] = { "~/.config/nvim/UltiSnips" }
vim.g["UltiSnipsExpandTrigger"] = "<tab>"
vim.g["UltiSnipsJumpForwardTrigger"] = "<tab>"
vim.g["UltiSnipsJumpBackwardTrigger"] = "<s-tab>"

-- Vimtex settings
vim.g["vimtex_view_general_viewer"] = "zathura"
vim.g["vimtex_quickfix_mode"] = 0
vim.g["vimtex_syntax_enabled"] = 1
vim.g["tex_conceal"] = "abdmg"
vim.g["vimtex_compiler_method"] = "tectonic"

-- Whichkey
local which_key = require("which-key")
which_key.setup({
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
})

local which_key_opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local which_key_mappings = {
    ["b"] = { "<cmd>VimtexCompile<CR>", "Build Vimtex" },
    ["v"] = { "<cmd>VimtexView<CR>", "View Vimtex" },
    ["w"] = { "<cmd>wa!<CR>", "Write" },
    f = {
        name = "Find",
        f = { "<cmd>Telescope find_files<CR>", "Files" },
        g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
    },
    s = {
        name = "Manage Sessions",
        s = { "<cmd>SessionManager save_current_session<CR>", "Save" },
        d = { "<cmd>SessionManager delete_session<CR>", "Delete" },
        l = { "<cmd>SessionManager load_session<CR>", "Load" },
    },
    q = {
        name = "Quit",
        q = { "<cmd>q<CR>", "Quit" },
        w = { "<cmd>wqa!<CR>", "Write and quit" },
        f = { "<cmd>qa!<CR>", "Force quit"},
    },
    v = {
        name = "Visual",
        s = { "<cmd>set colorcolumn=80<CR>", "Short color column" },
        l = { "<cmd>set colorcolumn=120<CR>", "Long color column" },
        c = { "<cmd>set colorcolumn=0<CR>", "Clear color column" },
    }
}

which_key.register(which_key_mappings, which_key_opts)

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
