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

  -- fuzzy finding w/ telescope
  use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }

  -- vs-code like icons
  use("nvim-tree/nvim-web-devicons")

  -- show line modifications on left hand side
  use {'lewis6991/gitsigns.nvim', tag ='v0.6'}

  -- tmux & split window navigation
  use("christoomey/vim-tmux-navigator")

  -- snippets
  use{"L3MON4D3/LuaSnip", tag = "v1.2.1"} -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- autocompletion
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion

  -- todo: after treesitter
  -- auto closing
  -- use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  -- use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- ======================
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- ======================
  if packer_bootstrap then
    require('packer').sync()
  end
end)
