-- Mason
vim.pack.add({"https://github.com/mason-org/mason.nvim"}) -- Pack Mason
require("config.plugins.masson")  -- Call Mason Config

-- Tree Sitter
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"}) --Pack Treesitter
require("config.plugins.treesitter") --Call Treesitter Config
