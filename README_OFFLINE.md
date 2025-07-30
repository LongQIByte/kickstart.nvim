# 🚀 Neovim Offline Development Package

[![Build Status](https://github.com/LongQIByte/kickstart.nvim/workflows/Build%20Offline%20Neovim%20Package/badge.svg)](https://github.com/LongQIByte/kickstart.nvim/actions)
[![Latest Release](https://img.shields.io/github/v/release/LongQIByte/kickstart.nvim?include_prereleases)](https://github.com/LongQIByte/kickstart.nvim/releases/latest)

完整的 Neovim 开发环境离线包，专为内网环境和离线开发设计。包含所有插件、LSP 服务器和开发工具。

## 🎯 特色功能

### 🔧 完整的 LSP 支持
- **Python**: pyright + black + isort + flake8
- **Go**: gopls + gofumpt + goimports
- **JavaScript/TypeScript**: ts_ls + prettier + eslint_d
- **HTML/CSS**: html + cssls + prettier
- **Vue**: volar (vue-language-server)  
- **Lua**: lua_ls + stylua

### 🤖 AI 智能编程
- **Codeium**: 免费的 GitHub Copilot 替代品
- **智能补全**: 基于上下文的代码建议
- **多语言支持**: 支持所有主流编程语言

### 🎨 丰富的插件生态
- **toggleterm.nvim**: 浮动终端切换 (Ctrl+\)
- **diffview.nvim**: Git 差异查看和合并冲突解决
- **telescope.nvim**: 模糊搜索和文件导航
- **nvim-treesitter**: 语法高亮和代码解析
- **which-key.nvim**: 快捷键提示
- **gitsigns.nvim**: Git 集成
- **conform.nvim**: 自动格式化
- **blink.cmp**: 智能自动补全

### ⚡ 开发体验优化
- **自动保存**: 智能的文件自动保存机制
- **格式化**: 保存时自动格式化代码
- **快捷键**: 完整的 Vim/Neovim 快捷键体系
- **美观界面**: 现代化的编辑器界面

## 📦 快速安装

### 方法一：自动安装脚本（推荐）

1. **下载离线包**：
   ```bash
   # 从 GitHub Releases 下载最新的 neovim-offline-package.tar.gz
   wget https://github.com/LongQIByte/kickstart.nvim/releases/latest/download/neovim-offline-package.tar.gz
   ```

2. **运行安装脚本**：
   ```bash
   # 下载安装脚本
   wget https://raw.githubusercontent.com/LongQIByte/kickstart.nvim/master/quick-install.sh
   chmod +x quick-install.sh
   
   # 运行安装
   ./quick-install.sh
   ```

### 方法二：手动安装

1. **解压包**：
   ```bash
   tar -xzf neovim-offline-package.tar.gz
   ```

2. **移动到用户目录**：
   ```bash
   # 备份现有配置（如果存在）
   mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
   mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
   
   # 解压到用户目录
   tar -xzf neovim-offline-package.tar.gz -C ~/
   ```

3. **启动 Neovim**：
   ```bash
   nvim
   ```

## 🎮 使用指南

### 基本操作

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `Ctrl+\` | 切换浮动终端 | 在任何时候快速打开/关闭终端 |
| `<leader>f` | 格式化代码 | 使用对应语言的格式化工具 |
| `<leader>sf` | 搜索文件 | 模糊搜索项目中的文件 |
| `<leader>sg` | 全局搜索 | 在项目中搜索文本内容 |
| `<leader><leader>` | 切换缓冲区 | 在打开的文件间快速切换 |

### Git 操作

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<leader>dv` | 打开 diff 视图 | 查看工作区变更 |
| `<leader>dc` | 关闭 diff 视图 | 退出 diff 模式 |
| `<leader>dh` | Git 历史 | 查看仓库提交历史 |
| `<leader>df` | 文件历史 | 查看当前文件的提交历史 |

### AI 代码补全 (Codeium)

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `Ctrl+G` | 接受建议 | 采用当前的 AI 代码建议 |
| `Ctrl+;` | 下一个建议 | 切换到下一个建议 |
| `Ctrl+,` | 上一个建议 | 切换到上一个建议 |
| `Ctrl+X` | 清除建议 | 清除当前显示的建议 |

### LSP 功能

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `grn` | 重命名符号 | 重命名变量、函数等 |
| `gra` | 代码动作 | 显示可用的代码修复动作 |
| `grr` | 查找引用 | 查找符号的所有引用 |
| `grd` | 跳转定义 | 跳转到符号定义处 |
| `K` | 显示文档 | 显示符号的文档信息 |

## 🔧 高级设置

### Codeium 认证

首次使用 AI 代码补全需要联网认证（仅一次）：

```vim
:Codeium Auth
```

### 自定义配置

所有配置文件位于 `~/.config/nvim/`，你可以根据需要修改：

- `init.lua` - 主配置文件
- `lua/` - 模块化配置目录

### Mason 工具管理

查看已安装的开发工具：

```vim
:Mason
```

## 📋 系统要求

### 支持的系统
- ✅ **Linux** (Ubuntu, CentOS, Arch, etc.)
- ✅ **macOS** (Intel & Apple Silicon)
- ✅ **Windows** (WSL/Git Bash)

### 依赖要求
- **Neovim**: 0.9+ (包含在离线包中)
- **磁盘空间**: ~1GB
- **内存**: 建议 2GB+

### 可选依赖
- **Git**: 用于版本控制功能
- **ripgrep**: 更快的文本搜索（推荐）
- **fd**: 更快的文件搜索（推荐）

## 🐛 故障排除

### 常见问题

**问题**: 首次启动很慢  
**解决**: 首次启动需要 10-30 秒初始化，属于正常现象

**问题**: LSP 服务器未启动  
**解决**: 等待几秒钟让 LSP 服务器完全加载

**问题**: AI 补全不工作  
**解决**: 运行 `:Codeium Auth` 进行认证

**问题**: 格式化不工作  
**解决**: 检查对应语言的格式化工具是否正确安装

### 重置配置

如果遇到问题，可以重置配置：

```bash
# 备份当前配置
mv ~/.config/nvim ~/.config/nvim.problematic
mv ~/.local/share/nvim ~/.local/share/nvim.problematic

# 重新解压离线包
tar -xzf neovim-offline-package.tar.gz -C ~/
```

### 获取帮助

1. **内置帮助**: `:help`
2. **插件文档**: `:help plugin-name`
3. **GitHub Issues**: [提交问题](https://github.com/LongQIByte/kickstart.nvim/issues)

## 📊 包内容详情

### 文件结构
```
neovim-offline-package.tar.gz
├── .config/nvim/              # Neovim 配置
│   ├── init.lua              # 主配置文件
│   ├── lua/                  # 模块化配置
│   ├── install-offline.sh    # 安装脚本
│   └── OFFLINE_USAGE.md      # 使用文档
├── .local/share/nvim/        # Neovim 数据
│   ├── lazy/                 # 插件目录
│   ├── mason/                # LSP 工具
│   └── site/                 # 站点包
├── .local/state/nvim/        # 状态文件
└── .cache/nvim/              # 缓存文件
```

### 包大小分解
- **基础配置**: ~10MB
- **插件文件**: ~100-200MB
- **LSP 服务器**: ~200-400MB
- **总计**: ~300-600MB

## 🔄 更新机制

### 自动构建
- 每次代码推送自动触发构建
- 生成最新的离线包
- 发布到 GitHub Releases

### 手动更新
1. 下载最新的离线包
2. 备份当前配置
3. 重新运行安装脚本

### 版本说明
- **Tagged releases**: 稳定版本 (v1.0.0, v1.1.0, etc.)
- **Auto releases**: 自动构建版本 (auto-123, auto-124, etc.)

## 🤝 贡献指南

### 参与开发
1. Fork 本仓库
2. 创建功能分支
3. 提交更改
4. 创建 Pull Request

### 反馈问题
- 🐛 [报告 Bug](https://github.com/LongQIByte/kickstart.nvim/issues/new?template=bug_report.md)
- 💡 [功能建议](https://github.com/LongQIByte/kickstart.nvim/issues/new?template=feature_request.md)
- 📖 [文档改进](https://github.com/LongQIByte/kickstart.nvim/issues/new?template=documentation.md)

## 📄 许可证

本项目基于 MIT 许可证开源。详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - 基础配置框架
- [Neovim](https://github.com/neovim/neovim) - 强大的编辑器
- [Lazy.nvim](https://github.com/folke/lazy.nvim) - 现代插件管理器
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - LSP 工具管理器

---

<div align="center">

**🚀 让编程更高效，让开发更愉快！**

[下载最新版本](https://github.com/LongQIByte/kickstart.nvim/releases/latest) • [查看文档](https://github.com/LongQIByte/kickstart.nvim/wiki) • [报告问题](https://github.com/LongQIByte/kickstart.nvim/issues)

</div>