local plugin = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000
}

function plugin.config()
  require("catppuccin").setup({
    color_overrides = {
      mocha = {
        base = "#0e0e0e",
        mantle = "#0e0e0e",
        crust = "#0e0e0e"
      }
    }
  })
  vim.cmd.colorscheme("catppuccin-mocha")
end

return plugin
