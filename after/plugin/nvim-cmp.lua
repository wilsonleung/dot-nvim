-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:Pmenu",
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:Pmenu",
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<A-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.scroll_docs(4)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<A-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.scroll_docs(-4)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

-- set keybinds for both INSERT and VISUAL.
-- vim.keymap.set({ "i", "s" }, "C-sp", function()
-- 	if luasnip.expand_or_jumpable() then
-- 		luasnip.expand()
-- 	end
-- end)
--
-- vim.keymap.set({ "i", "s" }, "C-]", function()
-- 	if luasnip.jumpable(1) then
-- 		luasnip.jump(1)
-- 	end
-- end)
--
-- vim.keymap.set({ "i", "s" }, "C-[", function()
-- 	if luasnip.jumpable(-1) then
-- 		luasnip.jump(-1)
-- 	end
-- end)
--
-- vim.keymap.set({ "i", "s" }, "C-sh", function()
-- 	if luasnip.choice_active() then
-- 		luasnip.change_choice(1)
-- 	end
-- end)
--
-- vim.keymap.set({ "i", "s" }, "C-sl", function()
-- 	if luasnip.choice_active() then
-- 		luasnip.change_choice(-1)
-- 	end
-- end)
