local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local config = {
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
    ["w"] = { "<cmd>wa!<CR>", "write" },
    f = {
        name = "Find",
        f = { "<cmd>Telescope find_files<CR>", "files" },
        g = { "<cmd>Telescope live_grep<CR>", "grep" },
    },
    s = {
        name = "Manage Sessions",
        s = { "<cmd>SessionManager save_current_session<CR>", "save" },
        d = { "<cmd>SessionManager delete_session<CR>", "delete" },
        l = { "<cmd>SessionManager load_session<CR>", "load" },
    },
    q = {
        name = "Quit",
        q = { "<cmd>q<CR>", "quit" },
        w = { "<cmd>wqa!<CR>", "write and quit" },
        f = { "<cmd>qa!<CR>", "Force quit"},
    }
}

which_key.setup(config)
which_key.register(mappings, opts)
