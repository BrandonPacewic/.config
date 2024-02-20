local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    print "Telescope not installed."
    return
end

local config = {
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
    },
}

telescope.setup(config)
