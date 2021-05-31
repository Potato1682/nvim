require'bufferline'.setup{
  options = {
    view = "multiwindow",
    tab_size = 24,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict)
      local s = " "

      for e, n in pairs(diagnostics_dict) do
        local sym =
             (e == "error" and " ")
          or (e == "warning" and " " or " " )

        s = s .. sym .. n
      end

      return s
    end,
    custom_filter = function(buf_number)
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end

      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end

      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    show_close_icon = false,
    separator_style = "thin",
    offsets = {{
      filetype = "NvimTree",
      text = "Explorer",
      text_align = "center"
    }}
  },
  highlights = {
    fill = {
      guibg = "#282C34"
    },
    separator_selected = {
      guibg = "#282C34"
    },
    buffer_selected = {
      gui = "italic"
    },
    info = {
      guifg = "#569CD6"
    },
    info_selected = {
      guifg = "#569CD6",
      guisp = "#569CD6"
    },
    info_diagnostic = {
      guisp = "#569CD6"
    },
    info_diagnostic_selected = {
      guifg = "#569CD6",
      guisp = "#569CD6"
    },
    warning = {
      guifg = "#D7BA7D"
    },
    warning_selected = {
      guifg = "#D7BA7D",
      guisp = "#D7BA7D"
    },
    warning_diagnostic = {
      guisp = "#D7BA7D"
    },
    warning_diagnostic_selected = {
      guifg = "#D7BA7D",
      guisp = "#D7BA7D"
    },
    error = {
      guifg = "#D16969"
    },
    error_selected = {
      guifg = "#D16969",
      guisp = "#D16969"
    },
    error_diagnostic = {
      guisp = "#D16969"
    },
    error_diagnostic_selected = {
      guifg = "#D16969",
      guisp = "#D16969"
    }
  }
}

