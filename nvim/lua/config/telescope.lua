local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local config = {
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
    },
}

telescope.setup(config)

-- local builtin = require "telescope.builtin"
-- vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
-- vim.keymap.set("n", "<leader>lg", telescope_builtin.live_grep)
