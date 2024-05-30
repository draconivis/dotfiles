return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  config = function()
    require("silicon").setup({
      -- Configuration here, or leave empty to use defaults
      font = "JetBrainsMonoNF=34",
    })
    vim.keymap.set("v", "sc", ":Silicon<CR>", { desc = "[S]creenshot [C]ode" })
  end
}
