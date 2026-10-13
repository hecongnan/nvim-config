# Neovim 配置

个人 Neovim 配置，基于 LazyVim 和 lazy.nvim。配置快照提取于 2026-10-13，本机 Neovim 版本为 0.12.5。

## 包含内容

- LazyVim 启动配置、插件锁定文件 `lazy-lock.json` 和额外语言配置。
- Dracula 主题、blink.cmp 的 super-tab 补全键位。
- clangd（C++23）和 ty（Python）语言服务器配置。
- CMake、Rust 和 TOML 的 LazyVim extras。
- CompetiTest 配置、C++ 算法代码片段，以及 `<Space>r` 运行当前文件的配置。
- VS Code Neovim 集成键位，以及 Neovide 字体和输入法选项。

## 安装

以下命令适用于 Linux 的 Bash。先关闭 Neovim；命令会备份已有配置，再克隆本仓库。若备份目标已存在，命令会停止。

```bash
(
  set -e
  config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
  mkdir -p "$config_dir"
  if [ -e "$config_dir/nvim" ] || [ -L "$config_dir/nvim" ]; then
    backup_dir="$config_dir/nvim.backup.$(date +%Y%m%d-%H%M%S)"
    if [ -e "$backup_dir" ] || [ -L "$backup_dir" ]; then
      echo "备份目录已存在：$backup_dir" >&2
      exit 1
    fi
    mv -- "$config_dir/nvim" "$backup_dir"
    echo "原配置已备份到：$backup_dir"
  fi
  git clone https://github.com/hecongnan/nvim-config.git "$config_dir/nvim"
)
nvim
```

首次启动时，lazy.nvim 会下载配置声明的插件，需要网络连接。`lazy-lock.json` 保留提取时的插件版本；需要恢复这些版本时，可在 Neovim 中使用 `:Lazy restore`。

## 环境与依赖

- 本快照来自 Neovim 0.12.5；包含针对 0.12 的配置，未验证较旧版本或其他系统。
- 需要 Git；查找功能通常还需要 ripgrep 和 fd。安装插件或语言工具时，按对应插件的实际提示准备依赖。
- `clangd` 和 `ty` 配置为系统可执行文件，关闭了对应的 Mason 安装管理。使用相关功能前需自行安装并加入 PATH。
- C/C++、Python、Java 的运行配置分别调用 `gcc`、`g++`、`python3`、`javac` 和 `java`；CompetiTest 的 Go 配置调用 `go`。
- Neovide 配置使用 `FiraCode Nerd Font`，需要本机安装该字体。
- CompetiTest 引用工作目录中的 `.template.cpp`；该文件未包含在此次配置提取中。

## 验证范围

保留原配置文件内容；对 JSON 文件进行了解析检查，并对 Lua 文件进行了语法编译检查。未执行全新环境的插件安装、完整启动或各语言工具的功能测试。

本仓库包含配置与代码片段，插件下载目录、缓存、会话与编辑历史不在此次提取范围内。原有 `LICENSE` 文件保持不变。
