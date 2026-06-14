return {
  interactions = {
    chat = { adapter = 'deepseek' },
    inline = { adapter = 'deepseek' },
    cmd = { adapter = 'deepseek' },
    cli = {
      agent = 'codex',
      agents = {
        codex = { cmd = 'codex' },
      },
      opts = {
        auto_insert = true,
      },
    },
  },
  adapters = {
    http = {
      gemini = function()
        return require 'codecompanion.adapters'.extend('gemini', {
          env = { api_key = 'cmd:rbw get --folder=API-KEY Gemini' } })
      end,
      deepseek = function()
        return require 'codecompanion.adapters'.extend('deepseek', {
          env = { api_key = 'cmd:rbw get --folder=API-KEY deepseek' } })
      end,
    },
  },
  prompt_library = {
    markdown = {
      dirs = { '~/.config/ai/prompts' },
    },
  },
  opts = {
    language = 'zh',
  },

  display = {
    chat = {
      start_in_insert_mode = true,
      auto_scroll = false,
    },
  },
}
