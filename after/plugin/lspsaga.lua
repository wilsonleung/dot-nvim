-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
  ui = {
    border = "rounded",
    title = false,
    -- colors = {
    --   normal_bg = "",
    --   title_bg = "",
    -- },
  },
  symbol_in_winbar = {
    enable = false
  },
  -- keybinds for navigation in lspsaga window
  scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
  -- use enter to open file with definition preview
  definition = {
    edit = "<CR>",
  },
  diagnostic = {
    border_follow = false,
    show_code_action = false,
    show_source = true
  },
  lightbulb = {
    enable = false
  }
})
