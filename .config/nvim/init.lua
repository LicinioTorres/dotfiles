-- Call keybinds
require("config.keymaps")

-- Call General Options
require("config.options")

-- Lsp Calls
require("config.lsp.lua_ls")            -- call lua-language-server
require("config.lsp.tinymist")          -- call tinymist (typst language server)

-- Call Theme
require("config.theme") -- highlight on yank

-- Call Vim Packer for Plugins
require("config.pack")

-- Call Functions
require("config.functions.yank-highlight") -- Highlight on yank
require("config.functions.wrap-logic") -- Highlight on yank


