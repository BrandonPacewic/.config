-- local colorscheme = "codedark"
local colorscheme = "everforest"
-- local colorscheme = "wal"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    print "Colorscheme not installed."
    return
end
