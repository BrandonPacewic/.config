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

vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print "Restart NeoVim required."
    return
end

local config = {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

local function plugins(use)
    use { "wbthomason/packer.nvim" }
    use { "nvim-lua/plenary.nvim" }

    -- Theme
    -- use { "tomasiser/vim-code-dark" }
    use { "sainnhe/everforest" }
    -- use { "dylanaraps/wal" }

    -- Startup Screen
    use { "goolord/alpha-nvim" }

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

    if packer_bootstrap then
        require("packer").sync()
    end
end

packer.init(config)
packer.startup(plugins)
