local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

local condition = require("galaxyline.condition")

local colors = {
  bg = "#282c34",
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
  red = "#e06c75"
}

gls.left[1] = {
  ViMode = {
    provider = function()
      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        [""] = colors.purple,
        V = colors.purple,
        c = colors.magenta,
        no = colors.blue,
        s = colors.orange,
        S = colors.orange,
        [""] = colors.orange,
        ic = colors.yellow,
        R = colors.red,
        Rv = colors.red,
        cv = colors.blue,
        ce = colors.blue,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.blue,
        t = colors.blue
      }

      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])

      return "██ "
    end,
    highlight = { colors.red, colors.bg }
  }
}

gls.left[2] = {
  GitIcon = {
    provider = function()
      return " "
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.vivid_orange, colors.bg }
  }
}

gls.left[3] = {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    separator = "  ",
    separator_highlight = { colors.dark_grey, colors.bg },
    highlight = { colors.grey, colors.bg }
  }
}

gls.left[4] = { DiffAdd = { provider = "DiffAdd", condition = condition.check_git_workspace, icon = " ", highlight = { "#a0c980", colors.bg } } }
gls.left[5] = {
  DiffModified = { provider = "DiffModified", condition = condition.check_git_workspace, icon = " ", highlight = { "#6cb6eb", colors.bg } }
}
gls.left[6] = {
  DiffRemove = { provider = "DiffRemove", condition = condition.check_git_workspace, icon = " ", highlight = { "#ec7239", colors.bg } }
}

gls.left[7] = { DiagnosticError = { provider = "DiagnosticError", icon = "  ", highlight = { colors.red, colors.bg } } }

gls.left[8] = { DiagnosticWarn = { provider = "DiagnosticWarn", icon = "  ", highlight = { colors.yellow, colors.bg } } }

gls.left[9] = { DiagnosticInfo = { provider = "DiagnosticInfo", icon = "  ", highlight = { colors.blue, colors.bg } } }

gls.left[10] = { DiagnosticHint = { provider = "DiagnosticHint", icon = "  ", highlight = { colors.green, colors.bg } } }

gls.right[1] = {
  FileIcon = { provider = "FileIcon", separator = " ", separator_highlight = { "NONE", colors.bg }, highlight = { colors.blue, colors.bg } }
}

gls.right[2] = { FileFormat = { provider = "FileFormat", highlight = { colors.grey, colors.bg } } }

gls.right[3] = {
  LineInfo = {
    provider = "LineColumn",
    icon = " ",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg }
  }
}

gls.right[4] = { LinePercent = { provider = "LinePercent", icon = " ", highlight = { colors.grey, colors.bg } } }

gls.right[5] = {
  ScrollBar = {
    provider = "ScrollBar",
    separator = " ",
    separator_highlight = { colors.dark_grey, colors.bg },
    highlight = { colors.blue, colors.bg }
  }
}

gls.short_line_left[1] = {
  FileTypeName = { provider = "FileTypeName", separator = " ", separator_highlight = { "NONE", colors.bg }, highlight = { colors.grey, colors.bg } }
}

gls.short_line_left[2] = { SFileName = { provider = "SFileName", condition = condition.buffer_not_empty, highlight = { colors.grey, colors.bg } } }

gls.short_line_right[1] = { BufferIcon = { provider = "BufferIcon", condition = condition.buffer_not_empty, highlight = { colors.grey, colors.bg } } }
