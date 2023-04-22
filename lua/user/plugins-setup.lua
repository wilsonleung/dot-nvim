local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- ======================
  -- users' plugin
  -- ======================

  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  -- Common utilities
  use {'nvim-lua/plenary.nvim', tag = 'v0.1.3'}

  -- Statusline
  use {'nvim-lualine/lualine.nvim', tag = 'compat-nvim-0.6'}

  -- commenting with gc
  use {'numToStr/Comment.nvim', tag = 'v0.8.0'}

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- vs-code like icons
  use("nvim-tree/nvim-web-devicons")

  -- show line modifications on left hand side
  use {'lewis6991/gitsigns.nvim', tag ='v0.6'}

  -- ======================
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- ======================
  if packer_bootstrap then
    require('packer').sync()
  end
end)
