-- bread's neovim config
-- keymaps are in lua/config/mappings.lua
-- install a patched font & ensure your terminal supports glyphs
-- enjoy :D

-- auto install vim-plug and plugins, if not found
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
    vim.cmd('silent !curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    vim.o.runtimepath = vim.o.runtimepath
    vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local vim = vim
-- Define plug as a function to handle optional arguments safely in Lua
local function plug(repo, opts)
  if opts then
    vim.fn['plug#'](repo, opts)
  else
    vim.fn['plug#'](repo)
  end
end

vim.g.start_time = vim.fn.reltime()
vim.loader.enable() 

vim.call('plug#begin')

-- Plugins
plug('rose-pine/neovim', { ['as'] = 'rose-pine' })
plug('rebelot/kanagawa.nvim', { ['as'] = 'kanagawa' })
plug('catppuccin/nvim', { ['as'] = 'catppuccin' }) 
plug('ellisonleao/gruvbox.nvim', { ['as'] = 'gruvbox' }) 
plug('uZer/pywal16.nvim', { [ 'as' ] = 'pywal16' }) 
plug('goolord/alpha-nvim') -- Fixes the 'alpha' module not found error
plug('nvim-lualine/lualine.nvim') 
plug('nvim-tree/nvim-web-devicons') 
plug('folke/which-key.nvim') 
plug('nvim-treesitter/nvim-treesitter') 
plug('nvim-tree/nvim-tree.lua') 
plug('romgrk/barbar.nvim') 
plug('windwp/nvim-autopairs') 
plug('lewis6991/gitsigns.nvim') 
plug('numToStr/Comment.nvim') 
plug('norcalli/nvim-colorizer.lua') 
plug('ibhagwan/fzf-lua') 
plug('numToStr/FTerm.nvim') 
plug('ron-rs/ron.vim') 
plug('MeanderingProgrammer/render-markdown.nvim') 
plug('emmanueltouzery/decisive.nvim') 
plug('folke/twilight.nvim')
plug('mfussenegger/nvim-lint')

vim.call('plug#end')

-- Configuration files
require("config.theme")
require("config.mappings")
require("config.options")
require("config.autocmd")

-- Plugin specific configs
-- We use pcall so Neovim doesn't crash if you haven't run :PlugInstall yet
local function safe_require(module)
    local status, _ = pcall(require, module)
    return status
end

safe_require("plugins.alpha")
safe_require("plugins.barbar")
safe_require("plugins.colorizer")
safe_require("plugins.colorscheme")
safe_require("plugins.comment")
safe_require("plugins.gitsigns")
safe_require("plugins.lualine")
safe_require("plugins.nvim-lint")
safe_require("plugins.render-markdown")

-- Trigger the initial theme load from your saved_theme file
-- This ensures the theme is applied AFTER plugins are initialized
if _G.load_theme then
    _G.load_theme()
end

vim.defer_fn(function() 
    -- defer non-essential items
end, 0)
