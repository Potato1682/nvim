local gl = require "galaxyline"
local gls = gl.section

gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

local condition = require "galaxyline.condition"

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
    highlight = { colors.red, colors.bg },
  },
}

gls.left[2] = {
  CurrentDirectory = {
    provider = function()
      return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
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
    condition = condition.hide_in_width or condition.check_git_workspace,
    separator = "   ",
    highlight = { colors.grey, colors.bg },
    separator_highlight = { colors.dark_grey, colors.bg },
  },
}

gls.left[5] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width or condition.check_git_workspace,
    icon = icons.get "diff-added" .. " ",
    highlight = { "#a0c980", colors.bg },
  },
}

gls.left[6] = {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width or condition.check_git_workspace,
    icon = icons.get "diff-modified" .. " ",
    highlight = { "#6cb6eb", colors.bg },
  },
}
gls.left[7] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width or condition.check_git_workspace,
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
  Diagnostics = {
    provider = function()
      return require("lsp-status").status()
    end,
    condition = condition.hide_in_width or condition.check_active_lsp,
    separator = " ",
    highlight = { "NONE", colors.bg },
    separator_highlight = { "NONE", colors.bg },
  },
}

gls.left[10] = {
  LspClient = {
    provider = "GetLspClient",
    condition = condition.hide_in_width or function()
      local tbl = { ["dashboard"] = true, [""] = true }

      if tbl[vim.opt.filetype] then
        return false
      end

      return true
    end,
    separator = " ",
    icon = "  ",
    highlight = { colors.magenta, colors.bg, "bold" },
    separator_highlight = { "NONE", colors.bg },
  },
}

gls.left[11] = {
  LightBulb = {
    provider = function()
      return require("nvim-lightbulb").get_status_text()
    end,
    condition = condition.check_active_lsp,
    highlight = { colors.green, colors.bg },
  },
}

gls.right[1] = {
  LineColumnIcon = {
    provider = function()
      return " "
    end,
    highlight = { colors.blue, colors.bg },
  },
}

gls.right[2] = {
  LineColumn = {
    provider = "LineColumn",
    icon = " ",
    highlight = { colors.grey, colors.bg },
  },
}

gls.right[3] = {
  IndentSize = {
    provider = function()
      if vim.opt.expandtab then
        return vim.opt.sts._value .. " Spaces"
      else
        return vim.opt.sw._value .. " Tab Width"
      end
    end,
    condition = condition.hide_in_width,
    highlight = { vim.opt.expandtab and colors.blue or colors.magenta },
  },
}

gls.right[4] = {
  FileEncode = {
    provider = "FileEncode",
    separator = " ",
    condition = condition.hide_in_width,
    highlight = { colors.green, colors.bg },
  },
}

gls.right[5] = {
  FileFormat = {
    provider = "FileFormat",
    condition = condition.hide_in_width,
    separator = " ",
    highlight = { colors.green, colors.bg },
  },
}

gls.right[6] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.hide_in_width or condition.buffer_not_empty,
    separator = "   ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
  },
}

gls.right[7] = {
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
