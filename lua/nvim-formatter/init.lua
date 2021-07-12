local format_install_dir = vim.fn.stdpath "data" .. "/fmtinstall/"

local lua_bin = format_install_dir .. "lua/stylua"

if vim.fn.filereadable(lua_bin) == 0 then
  require("nvim-formatter.install").install(
    "stylua",
    format_install_dir .. "lua",
    [[
      os=$(uname -s | tr "[:upper:]" "[:lower:]")
      case $os in
        linux)
          platform="linux"
          ;;
        darwin)
          platform="mac"
          ;;
      esac
      curl - Lo stylua.zip $(\
        curl - s "https://api.github.com/repos/JohnnyMorganz/StyLua/releases/latest" \
        | jq . \
        | grep - E "https?://.*\.zip" \
        | cut - d\" -f4 \
        | grep "$platform" \
      )
      unzip stylua.zip
      rm stylua.zip
      chmod +x stylua
    ]]
  )
end

local prettier_bin = format_install_dir .. "prettier/node_modules/.bin/prettier"

if vim.fn.filereadable(prettier_bin) == 0 then
  require("nvim-formatter.install").install(
    "prettier",
    format_install_dir .. "prettier",
    [[
    ! test -f package.json && npm init -y --scope=fmtinstall || true
    npm i prettier@latest
  ]]
  )
end

--[[ require("formatter").setup {
  logging = false,
  filetype = {
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = { "--emit=stdout" },
          stdin = true,
        }
      end,
    },
    less = {
      function()
        return {
          exe = prettier_bin,
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
            "--tab-width",
            vim.opt_local.tabstop._value,
            "--use-tabs",
            not vim.opt_local.expandtab._value,
          },
          stdin = true,
        }
      end,
    },
    scss = {
      function()
        return {
          exe = prettier_bin,
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
            "--tab-width",
            vim.opt_local.tabstop._value,
            "--use-tabs",
            not vim.opt_local.expandtab._value,
          },
          stdin = true,
        }
      end,
    },
    json = {
      function()
        return {
          exe = prettier_bin,
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
            "--tab-width",
            vim.opt_local.tabstop._value,
            "--use-tabs",
            not vim.opt_local.expandtab._value,
          },
          stdin = true,
        }
      end,
    },
    graphql = {
      function()
        return {
          exe = prettier_bin,
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
            "--tab-width",
            vim.opt_local.tabstop._value,
            "--use-tabs",
            not vim.opt_local.expandtab._value,
          },
          stdin = true,
        }
      end,
    },
    markdown = {
      function()
        return {
          exe = prettier_bin,
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
            "--tab-width",
            vim.opt_local.tabstop._value,
            "--use-tabs",
            not vim.opt_local.expandtab._value,
          },
          stdin = true,
        }
      end,
    },
    yaml = {
      function()
        return {
          exe = prettier_bin,
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
            "--tab-width",
            vim.opt_local.tabstop._value,
            "--use-tabs",
            not vim.opt_local.expandtab._value,
          },
          stdin = true,
        }
      end,
    },
    flow = {
      function()
        return {
          exe = prettier_bin,
          args = {
          },
          stdin = true,
        }
      end,
    },
  },
} ]]

vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_basic_format_trim = 1
vim.g.neoformat_only_msg_on_error = 1

local prettier_config = {
  exe = prettier_bin,
  args = {
    "--stdin-filepath",
    vim.api.nvim_buf_get_name(0),
    "--tab-width",
    vim.opt_local.tabstop._value,
    vim.opt_local.expandtab and "" or "--use-tabs",
  },
  stdin = 1,
}

vim.g.neoformat_css_prettier = prettier_config

vim.g.neoformat_graphql_prettier = prettier_config

vim.g.neoformat_html_prettier = prettier_config

vim.g.neoformat_json_prettier = prettier_config

vim.g.neoformat_kotlin_prettier = prettier_config

vim.g.neoformat_less_prettier = prettier_config

vim.g.neoformat_lua_stylua = {
  exe = lua_bin,
  args = {
    "-",
  },
  stdin = 1,
}

vim.g.neoformat_markdown_prettier = prettier_config

vim.g.neoformat_scss_prettier = prettier_config

vim.g.neoformat_xml_prettier = prettier_config

vim.g.neoformat_yaml_prettier = prettier_config

vim.g.neoformat_enable_css = {
  "prettier",
}

vim.g.neoformat_enabled_html = {
  "prettier",
}

vim.g.neoformat_enabled_java = {}

vim.g.neoformat_enabled_javascript = {}

vim.g.neoformat_enabled_json = {
  "prettier",
}

vim.g.neoformat_enabled_kotlin = {
  "prettier",
}

vim.g.neoformat_enabled_less = {
  "prettier",
}

vim.g.neoformat_enabled_lua = O.lua.formatter.enabled and {
  O.lua.formatter.use,
} or {}

vim.g.neoformat_enabled_markdown = {
  "prettier",
}

vim.g.neoformat_enabled_python = O.python.formatter.enabled and {
  O.python.formatter.use,
} or {}

vim.g.neoformat_enabled_scss = {
  "prettier",
}

vim.g.neoformat_enabled_typescript = {}

vim.g.neoformat_enabled_xml = {
  "prettier",
}

vim.g.neoformat_enabled_yaml = {
  "prettier",
}
