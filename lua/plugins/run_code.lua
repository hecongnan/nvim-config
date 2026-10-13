return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 12,
      direction = "float",
      float_opts = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      local toggleterm = require("toggleterm")
      toggleterm.setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal

      local function get_run_command()
        local ft = vim.bo.filetype
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.expand("%:p:h")
        local name = vim.fn.expand("%:t:r")

        if ft == "c" then
          return string.format("gcc '%s' -o '%s/%s' && '%s/%s'", file, dir, name, dir, name)
        elseif ft == "cpp" then
          return string.format("g++ -std=c++23 '%s' -o '%s/%s' && '%s/%s'", file, dir, name, dir, name)
        elseif ft == "python" then
          return string.format("python3 '%s'", file)
        elseif ft == "java" then
          return string.format("javac '%s' -d '%s' && java -cp '%s' %s", file, dir, dir, name)
        else
          vim.notify("Unsupported filetype: " .. ft, vim.log.levels.WARN)
          return nil
        end
      end

      vim.keymap.set("n", "<space>r", function()
        local cmd = get_run_command()
        if cmd then
          Terminal:new({
            cmd = cmd,
            dir = vim.fn.expand("%:p:h"),
            direction = "float",
            close_on_exit = false,
          }):toggle()
        end
      end, { desc = "Run current file" })
    end,
  },
}
