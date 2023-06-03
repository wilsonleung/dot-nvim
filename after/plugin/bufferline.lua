local status, bufferline = pcall(require, "bufferline")
if (not status) then return end


bufferline.setup({
  options = {
    separator_style = 'slant',
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = false,
    tab_size = 21,
    diagnostics = false, -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    offsets = { { filetype = "NvimTree", text = "", padding = 1, separator = true } },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
  highlights = {
    tab_separator_selected = {
      fg = '#ff0000',
      bg = '#ededed',
    },
    tab_selected = {
      fg = '#073642',
      bg = '#ededed',
    },
    separator = {
      fg = '#ededed',
      bg = '#ededed',
    },
    separator_selected = {
      fg = '#073642',
    },
    background = {
      fg = '#657b83',
      bg = '#002b36'
    },
    buffer_selected = {
      fg = '#fdf6e3',
      bold = true,
    },
    fill = {
      bg = '#ededed'
    }
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
