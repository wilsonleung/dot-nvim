-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

  --- show documentation for what is under cursor
  keymap.set("n", "<leader>h", "<cmd>Lspsaga hover_doc<CR>", opts)    -- hover
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>", opts)
  keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
  keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<CR>", opts)
  keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

  -- diagnostics related
  keymap.set("n", "<leader>ll", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
  keymap.set("n", "<leader>lc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "<leader>lp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)    -- jump to previous diagnostic in buffer
  keymap.set("n", "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)    -- jump to next diagnostic in buffer

  keymap.set("n", "<leader>lE",
    "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)
  keymap.set("n", "<leader>le",
    "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)

  keymap.set("n", "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)       -- list all diagnostic in buffer
  keymap.set("n", "<leader>lw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts) -- list all diagnostics in workspace
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  -- Call hierarchy
  keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
  keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>mi", ":TypescriptAddMissingImports<CR>") -- add missing import
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>")   -- organize imports (not in youtube nvim video)
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")        -- rename file and update imports
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>")      -- remove unused variables (not in youtube nvim video)
  end

  -- add lsp signature support
  -- require("lsp_signature").on_attach({
  -- 	bind = true,
  -- 	toggle_key = "<C-i>",
  -- 	hint_prefix = "⚙️  ",
  -- 	handler_opts = {
  -- 		border = "single",
  -- 	},
  -- }, bufnr)
end

local protocol = require("vim.lsp.protocol")
protocol.CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "ﰮ", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "﬌", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "ﬦ", -- Operator
  "", -- TypeParameter
}

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
-- lspconfig["tailwindcss"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    -- virtual_text = { spacing = 4, prefix = "●" },
    virtual_text = false,
    severity_sort = true,
  }
)
