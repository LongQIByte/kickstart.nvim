-- which-key 中文翻译配置
-- 为 which-key 提示添加中文翻译

local M = {}

-- 中文翻译映射表
local chinese_translations = {
  -- 基础操作
  ['[S]earch'] = '[搜索]',
  ['[T]oggle'] = '[切换]',
  ['[G]it [H]unk'] = '[Git] 代码块',
  ['[H]unk'] = '代码块',
  ['[S]earch [H]elp'] = '[搜索] 帮助',
  ['[S]earch [K]eymaps'] = '[搜索] 快捷键',
  ['[S]earch [F]iles'] = '[搜索] 文件',
  ['[S]earch [S]elect Telescope'] = '[搜索] 选择 Telescope',
  ['[S]earch current [W]ord'] = '[搜索] 当前单词',
  ['[S]earch by [G]rep'] = '[搜索] 通过 Grep',
  ['[S]earch [D]iagnostics'] = '[搜索] 诊断',
  ['[S]earch [R]esume'] = '[搜索] 恢复',
  ['[S]earch Recent Files ("." for repeat)'] = '[搜索] 最近文件 ("." 重复)',
  ['[ ] Find existing buffers'] = '[ ] 查找现有缓冲区',
  ['[S]earch [T]odos'] = '[搜索] 待办事项',
  
  -- 文件操作
  ['[F]ile'] = '[文件]',
  ['[N]ew file'] = '[新建] 文件',
  ['[O]pen file'] = '[打开] 文件',
  ['[S]ave file'] = '[保存] 文件',
  ['[S]ave all files'] = '[保存] 所有文件',
  ['[C]lose file'] = '[关闭] 文件',
  ['[Q]uit'] = '[退出]',
  ['[W]rite and quit'] = '[写入并退出]',
  
  -- 编辑操作
  ['[E]dit'] = '[编辑]',
  ['[C]opy'] = '[复制]',
  ['[C]ut'] = '[剪切]',
  ['[P]aste'] = '[粘贴]',
  ['[U]ndo'] = '[撤销]',
  ['[R]edo'] = '[重做]',
  ['[D]elete'] = '[删除]',
  ['[R]eplace'] = '[替换]',
  ['[F]ind'] = '[查找]',
  ['[F]ind and replace'] = '[查找并替换]',
  
  -- 窗口操作
  ['[W]indow'] = '[窗口]',
  ['[S]plit window'] = '[分割] 窗口',
  ['[V]ertical split'] = '[垂直] 分割',
  ['[H]orizontal split'] = '[水平] 分割',
  ['[C]lose window'] = '[关闭] 窗口',
  ['[M]aximize window'] = '[最大化] 窗口',
  ['[M]inimize window'] = '[最小化] 窗口',
  ['[R]esize window'] = '[调整] 窗口大小',
  
  -- 缓冲区操作
  ['[B]uffer'] = '[缓冲区]',
  ['[N]ext buffer'] = '[下一个] 缓冲区',
  ['[P]revious buffer'] = '[上一个] 缓冲区',
  ['[D]elete buffer'] = '[删除] 缓冲区',
  ['[W]ipe buffer'] = '[清除] 缓冲区',
  ['[L]ist buffers'] = '[列出] 缓冲区',
  
  -- 标签页操作
  ['[T]ab'] = '[标签页]',
  ['[N]ew tab'] = '[新建] 标签页',
  ['[C]lose tab'] = '[关闭] 标签页',
  ['[N]ext tab'] = '[下一个] 标签页',
  ['[P]revious tab'] = '[上一个] 标签页',
  ['[M]ove tab'] = '[移动] 标签页',
  
  -- Git 操作
  ['[G]it'] = '[Git]',
  ['[G]it [S]tatus'] = '[Git] 状态',
  ['[G]it [L]og'] = '[Git] 日志',
  ['[G]it [D]iff'] = '[Git] 差异',
  ['[G]it [B]lame'] = '[Git] 追溯',
  ['[G]it [C]ommit'] = '[Git] 提交',
  ['[G]it [P]ush'] = '[Git] 推送',
  ['[G]it [P]ull'] = '[Git] 拉取',
  ['[G]it [M]erge'] = '[Git] 合并',
  ['[G]it [R]ebase'] = '[Git] 变基',
  ['[G]it [S]tash'] = '[Git] 储藏',
  ['[G]it [B]ranch'] = '[Git] 分支',
  ['[G]it [T]ag'] = '[Git] 标签',
  
  -- LSP 操作
  ['[L]SP'] = '[LSP]',
  ['[L]SP [I]nfo'] = '[LSP] 信息',
  ['[L]SP [D]iagnostics'] = '[LSP] 诊断',
  ['[L]SP [R]eferences'] = '[LSP] 引用',
  ['[L]SP [D]efinition'] = '[LSP] 定义',
  ['[L]SP [T]ype definition'] = '[LSP] 类型定义',
  ['[L]SP [I]mplementation'] = '[LSP] 实现',
  ['[L]SP [H]over'] = '[LSP] 悬停',
  ['[L]SP [S]ignature help'] = '[LSP] 签名帮助',
  ['[L]SP [R]ename'] = '[LSP] 重命名',
  ['[L]SP [C]ode action'] = '[LSP] 代码操作',
  ['[L]SP [F]ormat'] = '[LSP] 格式化',
  ['[L]SP [O]rganize imports'] = '[LSP] 整理导入',
  
  -- 调试操作
  ['[D]ebug'] = '[调试]',
  ['[D]ebug [S]tart'] = '[调试] 开始',
  ['[D]ebug [S]top'] = '[调试] 停止',
  ['[D]ebug [R]estart'] = '[调试] 重启',
  ['[D]ebug [C]ontinue'] = '[调试] 继续',
  ['[D]ebug [S]tep over'] = '[调试] 单步跳过',
  ['[D]ebug [S]tep into'] = '[调试] 单步进入',
  ['[D]ebug [S]tep out'] = '[调试] 单步跳出',
  ['[D]ebug [B]reakpoint'] = '[调试] 断点',
  ['[D]ebug [V]ariables'] = '[调试] 变量',
  ['[D]ebug [W]atch'] = '[调试] 监视',
  ['[D]ebug [C]all stack'] = '[调试] 调用栈',
  
  -- 终端操作
  ['[T]erminal'] = '[终端]',
  ['[T]erminal [N]ew'] = '[终端] 新建',
  ['[T]erminal [T]oggle'] = '[终端] 切换',
  ['[T]erminal [S]end'] = '[终端] 发送',
  ['[T]erminal [R]un'] = '[终端] 运行',
  
  -- 其他常用操作
  ['[Q]uickfix'] = '[快速修复]',
  ['[L]ocation list'] = '[位置列表]',
  ['[M]arks'] = '[标记]',
  ['[J]umps'] = '[跳转]',
  ['[C]hanges'] = '[更改]',
  ['[R]egisters'] = '[寄存器]',
  ['[C]ommands'] = '[命令]',
  ['[H]istory'] = '[历史]',
  ['[S]essions'] = '[会话]',
  ['[P]lugins'] = '[插件]',
  ['[C]onfig'] = '[配置]',
  ['[H]elp'] = '[帮助]',
  ['[A]bout'] = '[关于]',
  
  -- 模式相关
  ['[N]ormal mode'] = '[普通] 模式',
  ['[I]nsert mode'] = '[插入] 模式',
  ['[V]isual mode'] = '[可视] 模式',
  ['[C]ommand mode'] = '[命令] 模式',
  ['[R]eplace mode'] = '[替换] 模式',
}

-- 获取中文翻译
function M.get_chinese_translation(english_text)
  return chinese_translations[english_text] or english_text
end

-- 为 which-key 添加中文翻译
function M.setup_chinese_translations()
  local which_key = require('which-key')
  
  -- 重写 which-key 的显示函数以添加中文翻译
  local original_show = which_key.show
  which_key.show = function(opts)
    -- 调用原始显示函数
    local result = original_show(opts)
    
    -- 如果显示成功，添加中文翻译
    if result then
      -- 延迟执行以确保窗口已经创建
      vim.defer_fn(function()
        -- 获取当前显示的窗口
        local win = vim.api.nvim_get_current_win()
        if not win or win == 0 then return end
        
        local buf = vim.api.nvim_win_get_buf(win)
        if not buf or buf == 0 then return end
        
        -- 获取缓冲区内容
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        
        -- 为每一行添加中文翻译
        local new_lines = {}
        for _, line in ipairs(lines) do
          local new_line = line
          -- 查找英文描述并添加中文翻译
          for english, chinese in pairs(chinese_translations) do
            -- 使用模式匹配来查找并替换英文描述
            local pattern = '(%s+)' .. vim.pesc(english) .. '(%s*)$'
            new_line = string.gsub(new_line, pattern, '%1' .. english .. ' ' .. chinese .. '%2')
          end
          table.insert(new_lines, new_line)
        end
        
        -- 更新缓冲区内容
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
      end, 50)
    end
    
    return result
  end
end

-- 设置中文翻译的 which-key 配置
function M.setup()
  -- 等待 which-key 加载完成
  vim.defer_fn(function()
    M.setup_chinese_translations()
  end, 100)
end

return M