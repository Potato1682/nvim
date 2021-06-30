O = {
  author = "", -- REQUIRED
  leader = " ",
  japanese = false,
  toggle = {
    enabled = true,
    user_tables = {
      ["=="] = "!=",
      ["==="] = "!=="
    }
  },
  auto_close_tree = 0,
  colorscheme = "edge",
  edge_better_performance = false, -- If true, edge shows some logs on startup
  -- @usage can be 'aura', 'neon'
  colorscheme_style = "neon",
  wrap_lines = false,
  number = true,
  relative_number = false,
  timeoutlen = 500,
  shell = "zsh",
  explorer = { disable_netrw = 0 },
  redmine = { site = "", api_key = "" },
  python = {
    -- @usage can be 'unittest', 'pytest'
    test_type = "pytest",
  },
  java = {
    format = {
      enabled = true,
      -- @usage Load .xml file from lua/lsp/java/styles, can use google-style and allman by default
      name = "google-style",
      profile = "GoogleStyle",
      on_type = false
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
      implementation = true
    },
    decompiler = {
      -- @usage can be 'common', 'cfr', 'fernflower', 'procyon'
      preferred = "fernflower"
    },
    autobuild = false
  },
  enter_event = {},
  color_event = {},
}
