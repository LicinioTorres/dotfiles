return{
  require('nvim-treesitter.config').setup({
    -- Automatically install these parsers
    ensure_installed = { 
      "typst", 
      "python", 
      "cpp", 
      "c",        -- Required dependency for many C++ features
      "lua",      -- Useful for Neovim config highlighting
      "vimdoc",   -- Recommended for Neovim help pages
      "query"     -- Recommended for Treesitter query files
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering a buffer
    auto_install = true,

    highlight = {
      enable = true,              -- Use Tree-sitter for syntax highlighting
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,              -- Use Tree-sitter for smarter indentation
    },

    -- Optional: Enable incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  })
}
