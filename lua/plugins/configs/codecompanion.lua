local gemini = { name = 'gemini', model = 'gemini-3.1-flash-lite-preview' }

return {
  interactions = {
    chat = { adapter = gemini },
    inline = { adapter = gemini },
    cmd = { adapter = gemini },
    background = { adapter = gemini },
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
    },
  },
}
