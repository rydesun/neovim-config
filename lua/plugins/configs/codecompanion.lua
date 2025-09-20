return {
  strategies = {
    chat = { adapter = 'gemini' },
    inline = { adapter = 'gemini' },
    cmd = { adapter = 'gemini' },
  },
  adapters = {
    http = {
      gemini = function()
        return require 'codecompanion.adapters'.extend('gemini', {
          env = { api_key = 'cmd:rbw get --folder=API-KEY Gemini' } })
      end,
    },
  },
  prompt_library = {
    Translate = {
      strategy = 'chat',
      opts = {
        auto_submit = true,
        is_slash_cmd = true,
        short_name = 'translate',
      },
      prompts = { {
        role = 'user',
        content = '翻译成中文(只需输出翻译文本，输出完后立即结束)：',
      } },
    },
  },
}
