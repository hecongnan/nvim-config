-- ============================================
-- Neovim 0.12+ 新特性集成
-- 在不改变现有配置的前提下启用新功能
-- ============================================

if vim.g.vscode then
  return {}
end

return {
  -- -----------------------------------------------
  -- 1. which-key: 注册 0.12 原生 LSP 快捷键说明
  --    这些键位由 Neovim 0.12 默认设置, 这里仅让
  --    which-key 能够发现并显示它们的描述
  -- -----------------------------------------------
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        {
          mode = { "n" },
          { "grn", desc = "LSP Rename (0.12 native)" },
          { "grr", desc = "LSP References (0.12 native)" },
          { "gri", desc = "LSP Implementation (0.12 native)" },
          { "gO", desc = "LSP Document Symbols (0.12 native)" },
        },
        {
          mode = { "n", "x" },
          { "gra", desc = "LSP Code Action (0.12 native)" },
        },
        {
          mode = { "n" },
          { "<leader>cL", group = "LSP Management" },
        },
      },
    },
  },

  -- -----------------------------------------------
  -- 2. LSP 管理快捷键 (利用 0.12 新增的 :lsp 命令)
  -- -----------------------------------------------
  {
    "neovim/nvim-lspconfig",
    optional = true,
    keys = {
      { "<leader>cLi", "<cmd>lsp<cr>", desc = "LSP Info (:lsp)" },
      { "<leader>cLr", "<cmd>lsp restart *<cr>", desc = "LSP Restart All" },
      { "<leader>cLs", "<cmd>lsp stop *<cr>", desc = "LSP Stop All" },
      { "<leader>cLl", "<cmd>lsp log<cr>", desc = "LSP Log" },
    },
  },

  -- -----------------------------------------------
  -- 3. 诊断增强: 虚拟文本显示切换
  --    0.12 对 vim.diagnostic.config() 进行了改进,
  --    支持更灵活的虚拟文本配置
  -- -----------------------------------------------
  {
    "snacks.nvim",
    keys = {
      {
        "<leader>uV",
        function()
          -- 获取当前虚拟文本配置
          local current = vim.diagnostic.config()
          if current and current.virtual_text then
            vim.diagnostic.config({ virtual_text = false })
            vim.notify("Diagnostic virtual text: OFF", vim.log.levels.INFO)
          else
            vim.diagnostic.config({
              virtual_text = {
                spacing = 4,
                prefix = "●",
              },
            })
            vim.notify("Diagnostic virtual text: ON", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Diagnostic Virtual Text",
      },
    },
  },
}
