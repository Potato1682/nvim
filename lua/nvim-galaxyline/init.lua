local gl = require "galaxyline"
local gls = gl.section

gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

local condition = require "galaxyline.condition"

local colors = {
  bg = "#2a2c34",
  yellow = "#e5c07b",
  orange = "#e6a370",
  vivid_orange = "#ff8800",
  cyan = "#56b6c2",
  green = "#98c379",
  magenta = "#c678dd",
  purple = "#a278dd",
  grey = "#abb2bf",
  dark_grey = "#70757d",
  blue = "#61afef",
  red = "#e06c75",
}

local icons = require "nvim-nonicons"

gls.left[1] = {
  ViMode = {
    provider = function()
      local mode_color = {
        n = { colors.blue, icons.get "vim-normal-mode" },
        i = { colors.green, icons.get "vim-insert-mode" },
        v = { colors.purple, icons.get "vim-visual-mode" },
        [""] = { colors.purple, icons.get "vim-visual-mode" },
        V = { colors.purple, icons.get "vim-visual-mode" },
        c = { colors.magenta, icons.get "vim-command-mode" },
        no = { colors.blue, icons.get "vim-normal-mode" },
        s = { colors.orange, icons.get "vim-select-mode" },
        S = { colors.orange, icons.get "vim-select-mode" },
        [""] = { colors.orange, icons.get "vim-select-mode" },
        R = { colors.red, icons.get "vim-replace-mode" },
        Rv = { colors.red, icons.get "vim-replace-mode" },
        cv = { colors.blue, icons.get "vim-normal-mode" },
        ce = { colors.blue, icons.get "vim-normal-mode" },
        ["!"] = { colors.blue, icons.get "vim-normal-mode" },
        t = { colors.blue, icons.get "vim-terminal-mode" },
      }

      vim.api.nvim_command("hi GalaxyViMode guifg=bg guibg=" .. mode_color[vim.fn.mode()][1])

      return "  " .. mode_color[vim.fn.mode()][2] .. "  "
    end,
    separator = "  ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { "NONE", colors.bg },
  },
}

gls.left[2] = {
  CurrentDirectory = {
    provider = function()
      return "  " .. vim.fn.fnamemodify(vim.loop.cwd(), ":t")
    end,
    icon = icons.get "file-directory-outline",
    separator = "   ",
    highlight = { colors.blue, colors.bg },
    separator_highlight = { colors.dark_grey, colors.bg },
  },
}

gls.left[3] = {
  GitIcon = {
    provider = function()
      return " " .. icons.get "git-branch"
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.vivid_orange, colors.bg },
  },
}

gls.left[4] = {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.hide_in_width and condition.check_git_workspace,
    separator = "   ",
    highlight = { colors.grey, colors.bg },
    separator_highlight = { colors.dark_grey, colors.bg },
  },
}

gls.left[5] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width and condition.check_git_workspace,
    icon = icons.get "diff-added" .. " ",
    highlight = { "#a0c980", colors.bg },
  },
}

gls.left[6] = {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width and condition.check_git_workspace,
    icon = icons.get "diff-modified" .. " ",
    highlight = { "#6cb6eb", colors.bg },
  },
}
gls.left[7] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width and condition.check_git_workspace,
    icon = icons.get "diff-removed" .. " ",
    highlight = { "#ec7239", colors.bg },
  },
}

gls.left[8] = {
  DiagnosticsSeparator = {
    provider = function()
      return "   "
    end,
    condition = condition.check_git_workspace,
    highlight = { colors.dark_grey, colors.bg },
  },
}

gls.left[9] = {
  Breadcrumb = {
    provider = function()
      return require("nvim-gps").get_location()
    end,
    condition = function()
      local ok, gps = pcall(require, "nvim-gps")

      if not ok then
        return false
      end

      return gps.is_available()
    end,
    separator = " ",
    highlight = { colors.blue, colors.bg },
    separator_highlight = { "NONE", colors.bg },
  },
}

gls.left[10] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = icons.get "x-circle" .. " ",
    highlight = { "#db4b4b", colors.bg },
  },
}

gls.left[11] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = icons.get "alert" .. " ",
    highlight = { "#e0af68", colors.bg },
  },
}

gls.left[12] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = icons.get "info" .. " ",
    highlight = { "#0db9d7", colors.bg },
  },
}

gls.left[13] = {
  DiagnosticsHint = {
    provider = "DiagnosticHint",
    icon = icons.get "light-bulb" .. " ",
    highlight = { "#a0c980", colors.bg },
  },
}

gls.left[14] = {
  LspFine = {
    provider = function()
      return icons.get "check"
    end,
    condition = condition.hide_in_width and function()
      if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
        return false
      end

      local levels = {
        errors = "Error",
        warnings = "Warning",
        info = "Information",
        hints = "Hint",
      }

      for _, level in pairs(levels) do
        if vim.lsp.diagnostic.get_count(vim.api.nvim_get_current_buf(), level) > 0 then
          return false
        end
      end

      return true
    end,
    separator = " ",
    highlight = { "#a0c980", colors.bg },
    separator_highlight = { "NONE", colors.bg },
  },
}

gls.left[15] = {
  LspClient = {
    provider = function()
      local clients = {}

      for _, client in pairs(vim.lsp.buf_get_clients()) do
        if client.name == "pyright" then
          if CURRENT_VENV ~= nil then
            local venv_name = client.config.settings.python.venv_name or "venv"

            if CURRENT_VENV ~= "venv" then
              venv_name = CURRENT_VENV
            end

            clients[#clients + 1] = client.name .. "(" .. venv_name .. ")"
          end
        else
          clients[#clients + 1] = client.name
        end
      end

      return table.concat(clients, " ")
    end,
    condition = condition.hide_in_width and function()
      local tbl = { ["dashboard"] = true, [""] = true }

      if tbl[vim.opt.filetype] then
        return false
      end

      return true
    end,
    separator = " ",
    icon = icons.get "gear" .. " ",
    highlight = { colors.magenta, colors.bg },
    separator_highlight = { "NONE", colors.bg },
  },
}

gls.left[16] = {
  LightBulb = {
    provider = function()
      if vim.b.current_lightbulb_status_text == nil then
        vim.b.current_lightbulb_status_text = ""
      end

      return require("nvim-lightbulb").get_status_text()
    end,
    condition = condition.check_active_lsp,
    highlight = { colors.green, colors.bg },
  },
}

gls.right[1] = {
  CurrentContainer = {
    provider = function()
      return icons.get "container" .. " " .. vim.g.currentContainer
    end,
    condition = function()
      return not not vim.g.currentContainer
    end,
    highlight = { "#d38aea", colors.bg },
  },
}

gls.right[2] = {
  LineColumnIcon = {
    provider = function()
      return " "
    end,
    highlight = { colors.blue, colors.bg },
  },
}

gls.right[3] = {
  LineColumn = {
    provider = "LineColumn",
    icon = " ",
    highlight = { colors.grey, colors.bg },
  },
}

gls.right[4] = {
  IndentSize = {
    provider = function()
      if vim.opt_local.expandtab:get() then
        return vim.opt_local.tabstop:get() .. " Spaces"
      else
        return vim.opt_local.shiftwidth:get() .. " Tab Width"
      end
    end,
    condition = condition.hide_in_width,
    highlight = { vim.opt.expandtab and colors.blue or colors.magenta, colors.bg },
  },
}

gls.right[5] = {
  FileEncode = {
    provider = "FileEncode",
    separator = " ",
    condition = condition.hide_in_width,
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.green, colors.bg },
  },
}

gls.right[6] = {
  FileFormat = {
    provider = "FileFormat",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.green, colors.bg },
  },
}

gls.right[7] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.hide_in_width or condition.buffer_not_empty,
    separator = "   ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
  },
}

gls.right[8] = {
  FileSize = {
    provider = "FileSize",
    condition = condition.hide_in_width,
    highlight = { colors.grey, colors.bg },
  },
}

gls.short_line_left[1] = {
  ShortSymbol = {
    provider = function()
      return "▊ "
    end,
    highlight = { colors.dark_grey, colors.bg, "bold" },
  },
}

gls.short_line_left[2] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = { colors.dark_grey, colors.bg, "bold" },
  },
}

gls.short_line_left[3] = {
  FileName = {
    provider = "FileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.dark_grey, colors.bg },
  },
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    condition = condition.buffer_not_empty,
    highlight = { colors.dark_grey, colors.bg },
  },
}
