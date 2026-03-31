-- Python DAP 配置
-- 提供 Python 调试支持，包括虚拟环境自动检测

return {
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    -- 不在 ft 中懒加载，确保 DAP 配置能正确初始化
    config = function()
      local dap_python = require('dap-python')
      local dap = require('dap')
      local dapui = require('dapui')

      -- 检查 debugpy 是否安装
      local function get_debugpy_path()
        local ok, mason_registry = pcall(require, 'mason-registry')
        if not ok then
          return nil
        end
        if mason_registry.has_package('debugpy') then
          local debugpy_pkg = mason_registry.get_package('debugpy')
          -- 兼容不同版本的 Mason API
          local install_path
          if debugpy_pkg.get_install_path then
            install_path = debugpy_pkg:get_install_path()
          elseif debugpy_pkg.installation then
            install_path = debugpy_pkg.installation.path
          else
            -- 直接构造路径
            install_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy'
          end
          -- debugpy 实际路径在 venv/bin/python
          return install_path .. '/venv/bin/python'
        end
        return nil
      end

      -- 自动检测 Python 解释器路径
      local function get_python_path()
        -- 1. 检查当前激活的虚拟环境
        local venv = os.getenv('VIRTUAL_ENV')
        if venv then
          return venv .. '/bin/python'
        end

        -- 2. 检查项目根目录的常见虚拟环境目录
        local cwd = vim.fn.getcwd()
        local venv_dirs = { 'venv', '.venv', 'env', '.env' }
        for _, dir in ipairs(venv_dirs) do
          local python_path = cwd .. '/' .. dir .. '/bin/python'
          if vim.fn.filereadable(python_path) == 1 then
            return python_path
          end
        end

        -- 3. 检查 Poetry 虚拟环境
        local handle = io.popen('poetry env info -p 2>/dev/null')
        if handle then
          local poetry_venv = handle:read('*a'):gsub('%s+', '')
          handle:close()
          if poetry_venv ~= '' then
            return poetry_venv .. '/bin/python'
          end
        end

        -- 4. 检查 Conda 环境
        local conda_prefix = os.getenv('CONDA_PREFIX')
        if conda_prefix then
          return conda_prefix .. '/bin/python'
        end

        -- 5. 回退到系统 Python
        return vim.fn.exepath('python3') or vim.fn.exepath('python')
      end

      -- 手动选择 Python 解释器
      local function select_python_interpreter()
        local cwd = vim.fn.getcwd()
        local paths = {
          cwd .. '/venv/bin/python',
          cwd .. '/.venv/bin/python',
          cwd .. '/env/bin/python',
          cwd .. '/.env/bin/python',
          vim.fn.exepath('python3'),
          vim.fn.exepath('python'),
        }

        -- 添加 Mason 的 debugpy
        local debugpy_path = get_debugpy_path()
        if debugpy_path then
          table.insert(paths, 1, debugpy_path)
        end

        -- 添加 Poetry 环境
        local handle = io.popen('poetry env info -p 2>/dev/null')
        if handle then
          local poetry_venv = handle:read('*a'):gsub('%s+', '')
          handle:close()
          if poetry_venv ~= '' then
            table.insert(paths, 1, poetry_venv .. '/bin/python')
          end
        end

        -- 过滤存在的路径
        local valid_paths = {}
        for _, p in ipairs(paths) do
          if vim.fn.filereadable(p) == 1 then
            table.insert(valid_paths, p)
          end
        end

        if #valid_paths == 0 then
          vim.notify('未找到可用的 Python 解释器', vim.log.levels.WARN)
          return
        end

        vim.ui.select(valid_paths, {
          prompt = '选择 Python 解释器:',
          format_item = function(item)
            if item:match('mason') then
              return item .. ' [Mason debugpy]'
            elseif item:match('/venv/') or item:match('/.venv/') then
              return item .. ' [虚拟环境]'
            elseif item:match('/poetry/') or item:match('pypoetry') then
              return item .. ' [Poetry]'
            elseif item == vim.fn.exepath('python3') then
              return item .. ' [系统 Python3]'
            else
              return item
            end
          end,
        }, function(choice)
          if choice then
            dap_python.setup(choice)
            vim.notify('已切换 Python 解释器: ' .. choice, vim.log.levels.INFO)
          end
        end)
      end

      -- 配置 debugpy - 优先使用 Mason 安装的版本
      local debugpy_path = get_debugpy_path()
      local python_path = get_python_path()

      if debugpy_path then
        dap_python.setup(debugpy_path)
        vim.g.dap_python_using_mason = true
      else
        dap_python.setup(python_path)
        vim.g.dap_python_using_mason = false
        vim.notify('debugpy 未通过 Mason 安装，使用系统 Python: ' .. python_path, vim.log.levels.WARN)
      end

      -- 添加 Python 调试配置
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file (auto venv)',
          program = '${file}',
          pythonPath = get_python_path,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file with arguments',
          program = '${file}',
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, ' +')
          end,
          pythonPath = get_python_path,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch module',
          module = function()
            return vim.fn.input('Module name: ')
          end,
          pythonPath = get_python_path,
        },
        {
          type = 'python',
          request = 'attach',
          name = 'Attach remote',
          connect = {
            host = function()
              return vim.fn.input('Host [127.0.0.1]: ') or '127.0.0.1'
            end,
            port = function()
              return tonumber(vim.fn.input('Port [5678]: ') or '5678')
            end,
          },
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Debug Django',
          program = '${workspaceFolder}/manage.py',
          args = { 'runserver', '--noreload' },
          django = true,
          pythonPath = get_python_path,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Debug FastAPI',
          module = 'uvicorn',
          args = function()
            local main_file = vim.fn.input('Main file [main:app]: ') or 'main:app'
            return { main_file, '--reload' }
          end,
          pythonPath = get_python_path,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Debug pytest (current file)',
          module = 'pytest',
          args = { '${file}', '-v' },
          pythonPath = get_python_path,
        },
      }

      -- 设置键位映射
      vim.keymap.set('n', '<leader>dp', select_python_interpreter, {
        desc = '[D]ebug [P]ython interpreter [选择Python解释器]',
      })

      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.open()
      end, { desc = '[D]ebug [R]EPL [调试控制台]' })

      vim.keymap.set('n', '<leader>dl', function()
        dap.set_log_level('DEBUG')
        vim.notify('DAP 日志级别已设置为 DEBUG', vim.log.levels.INFO)
      end, { desc = '[D]ebug [L]og level [调试日志级别]' })

      -- 显示 DAP 状态
      vim.keymap.set('n', '<leader>ds', function()
        local mason_status = vim.g.dap_python_using_mason and '是' or '否'
        local info = string.format(
          'DAP Python 状态:\n- 使用 Mason debugpy: %s\n- 当前 Python 路径: %s',
          mason_status,
          get_python_path()
        )
        vim.notify(info, vim.log.levels.INFO)
      end, { desc = '[D]ebug [S]tatus [调试状态]' })

      vim.notify('Python DAP 配置已加载', vim.log.levels.INFO)
    end,
  },
}
