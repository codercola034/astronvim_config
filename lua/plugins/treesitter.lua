---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "go",
      "python",
      "javascript",
      "typescript",
      "tsx",
      "json",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
