local plugin = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate"
}

function plugin.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "html",
      "css",
      "java"
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return plugin
