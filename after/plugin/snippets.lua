local status, ls = pcall(require, "luasnip")
if not status then
	return
end

ls.config.set_config({
	history = true,
	update_events = "TextChanged,TextChangedI",
})

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local function captialized(str)
	return str:gsub("^%l", string.upper)
end

ls.add_snippets(nil, {
	typescriptreact = {
		snip(
			{
				trig = "useState",
				namr = "useState",
				dscr = "react useState hook",
				priority = 2000,
			},
			fmt([[const [{state}, set{setter}] = useState({})]], {
				state = insert(1, "state"),
				setter = func(function(arg, _)
					return captialized(arg[1][1])
				end, { 1 }),
				insert(2),
			})
		),
	},
})
