require("user.opts")
require("user.maps")
require("user.plugins")

-- neovide settings
if vim.g.neovide then
	vim.g.neovide_transparency = 0.9
	vim.g.neovide_cursor_animation_length = 0
end
