local status_ok_sm, session_manager = pcall(require, "session_manager")
local status_ok_path, Path = pcall(require, "plenary.path")
if not status_ok_sm or not status_ok_path then
    print "Session Manager not installed."
    return
end

local config = {
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
}

session_manager.setup(config)
