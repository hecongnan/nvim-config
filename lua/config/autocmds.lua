-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ============================================
-- Neovim 0.12+ 新特性: LSP 增强
-- ============================================

-- 利用 0.12 改进的 vim.lsp API 增强 LSP 体验
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("nvim012_lsp_enhancements", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local bufnr = args.buf

    -- 0.12: CodeLens 自动刷新 (显示引用计数、测试运行按钮等)
    if client:supports_method("textDocument/codeLens") then
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("nvim012_codelens_" .. bufnr, { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end,
      })
      -- 快捷键运行 CodeLens
      vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.run, {
        buffer = bufnr,
        desc = "Run CodeLens (0.12)",
      })
    end
  end,
})
