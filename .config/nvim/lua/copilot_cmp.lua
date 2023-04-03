-- @see https://github.com/hrsh7th/cmp-copilot

local source = {}

source.new = function()
  return setmetatable({
    timer = vim.loop.new_timer()
  }, { __index = source })
end

source.get_debug_name = function ()
  return 'Copilot'
end

source.get_keyword_pattern = function()
  return '.'
end

source.parse_completion_item = function (self, params, item)
  local prefix = string.sub(
    params.context.cursor_before_line,
    item.range.start.character + 1,
    item.position.character
  )

  return {
    label = prefix .. item.displayText,
    kind = 1,
    cmp = {
      kind_text = 'Copilot',
    },
    textEdit = {
      range = item.range,
      newText = item.text,
    },
    documentation = {
      kind = 'markdown',
      value = table.concat({
        '```' .. vim.api.nvim_buf_get_option(0, 'filetype'),
        self:deindent(item.text),
        '```'
      }, '\n'),
    }
  }
end

source.complete = function(self, params, callback)
  vim.fn['copilot#Complete'](function(result)
    callback({
      isIncomplete = true,
      items = vim.tbl_map(function (item)
          return self:parse_completion_item(params, item)
        end,
        (result or {}).completions or {}
      )
    })
  end, function(result)
    callback({
      isIncomplete = true,
      items = vim.tbl_map(function (item)
          return self:parse_completion_item(params, item)
        end,
        (result or {}).completions or {}
      )
    })
  end)
end

source.deindent = function(_, text)
  local indent = string.match(text, '^%s*')
  if not indent then
    return text
  end
  return string.gsub(string.gsub(text, '^' .. indent, ''), '\n' .. indent, '\n')
end

return source

