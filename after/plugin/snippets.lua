local status, ls = pcall(require, "luasnip")
if not status then
	return
end

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function()
	return { os.date("%Y-%m-%d") }
end

local function captialized(str)
	return str:gsub("^%l", string.upper)
end

ls.add_snippets(nil, {
	typescriptreact = {
		snip({
			trig = "useState",
			namr = "useState",
			dscr = "react useState hook",
			priority = 2000,
		}, {
			text("const ["),
			insert(1, "state"),
			text(", set"),
			func(function(arg, _)
				return captialized(arg[1][1])
			end, { 1 }),
			text("] = useState()"),
		}),
	},
})
