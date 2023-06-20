return {
  "jackMort/ChatGPT.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  event = "VeryLazy",
  opts = {},
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "echo $OPENAI_API_KEY",
      edit_with_instructions = {
        diff = false,
        keymaps = {
          close = "<C-c>",
          accept = "<C-S-y>",
          toggle_diff = "<C-S-d>",
          toggle_settings = "<C-S-o>",
          cycle_windows = "<C-S-Tab>",
          use_output_as_input = "<C-S-i>",
        },
      },
      openai_params = {
        model = "gpt-3.5-turbo-16k",
        --model = "gpt-4",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 14000,
        --max_tokens = 6000,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      actions_paths = { "~/.config/nvim/lua/plugins/chatgpt-actions.json" },
    })
  end,
}
