data_dir = vim.fn.stdpath "data" .. "/"
config_dir = vim.fn.stdpath "config" .. "/"

-- This is settings section

O = {
  author = "", -- REQUIRED
  leader = " ",
  localleader = ",",
  japanese = false,
  toggle = {
    enabled = true,
    user_tables = {
      ["=="] = "!=",
      ["==="] = "!==",
    },
  },
  scroll = {
    scrolloff = 4,
    sidescrolloff = 16,
  },
  cursor = {
    vfx = "pixeldust", -- Neovide only
  },
  notification = {
    -- @usage can be 'fade_slide_out', 'fade', 'slide' and 'static'
    animation_style = "fade_in_slide_out"
  },
  font = "JetBrains Mono NF",
  textwidth = 120,
  colorscheme = "amethyst",
  edge_better_performance = true, -- If true, edge shows some logs on startup
  -- @usage can be 'aura', 'neon'
  colorscheme_style = "neon",
  wrap_lines = true,
  cursorline = true,
  cursorcolumn = false,
  number = true,
  relative_number = true,
  timeoutlen = 350,
  shell = "zsh",
  explorer = {
    disable_netrw = false,
    auto_close = false,
  },
  redmine = {
    enabled = false,
    site = "",
    api_key = "",
  },
  wakatime = {
    enabled = false,
  },
  yadm = {
    enabled = vim.fn.executable "yadm" == 1,
  },
  -- Add ignored commands in history
  ignore_commands = {},
  lua = {
    formatter = {
      enabled = true,
      -- @usage can be 'stylua', 'luaformatter', 'lua-fmt', 'lua-format'
      -- 'stylua' is preinstalled
      use = "stylua",
    },
  },
  typescript = {
    on_save = {
      organize_imports = true,
    },
  },
  python = {
    -- @usage can be 'unittest', 'pytest'
    test_type = "pytest",
    spaces_between_default_param = false,
    formatter = {
      enabled = true,
      -- @usage can be 'yapf', 'autopep8', 'black', 'pydevf', 'isort', 'docformatter', 'pyment'
      -- You need to install selected formatter
      use = "yapf",
    },
  },
  java = {
    format = {
      enabled = true,
      -- @usage Load .xml file from lua/lsp/java/styles, can use google-style and allman by default
      name = "google-style",
      profile = "GoogleStyle",
      on_type = false,
    },
    -- @usage set your java runtime
    runtimes = {
      {
        name = "JavaSE-1.8",
        path = "/usr/lib/jvm/java-8-openjdk",
        default = true,
      },
      {
        name = "JavaSE-11",
        path = "/usr/lib/jvm/java-11-openjdk",
      },--[[, {
      name = "JavaSE-16",
      path = "/usr/lib/jvm/zulu-16"
    }]]
    },
    codelens = {
      references = true,
      implementation = true,
    },
    decompiler = {
      -- @usage can be 'common', 'cfr', 'fernflower', 'procyon'
      preferred = "fernflower",
    },
    autobuild = false,
  },
  vue = {
    initial_indent = {
      script = false,
      style = false,
    },
  },
  enter_event = {},
  color_event = {},
}
