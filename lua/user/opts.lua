vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true

vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- No Wrap lines
vim.opt.wrap = false

vim.opt.backspace = { "start", "eol", "indent" }

-- Finding files - Search down into subfolders
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Undercurl
--vim.cmd([[let &t_Cs = "\e[4:3m"]])
--vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- consider string-string as whole word
vim.opt.iskeyword:append("-")

-- show sign column so that text doesn't shift
vim.opt.signcolumn = "yes"

-- highlight related
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

-- clipboard handling
local has = vim.fn.has
local is_mac = has("macunix")
local is_win = has("win32")
local is_wsl = has("wsl")

if is_mac then
	vim.opt.clipboard:append({ "unnamedplus" })
end
if is_win then
	vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
end
