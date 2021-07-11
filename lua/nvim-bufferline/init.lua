require("bufferline").setup {
  options = {
    view = "multiwindow",
    tab_size = 24,
    close_command = function(bufnum)
      require("modules.buffer").delete_buffer(bufnum)
    end,
    right_mouse_command = function(bufnum)
      vim.api.nvim_input "<ESC>"

      local choises = {
        " New Buffer        ",
        " Close             ",
        " Close All         ",
        "",
        "/Copy Path         ",
        " Copy Relative Path",
        "",
        " Split Vertically  ",
        " Split Horizontally",
        " Move Right        ",
        " Move Left         ",
        "  Pick Buffers ...  ",
        "  Sort By .extension",
        "  Sort By directory/",
        "  Sort By /directory",
        "",
        " Select Next Buffer",
        " Select Prev Buffer",
      }

      local choise_callbacks = {
        function()
          vim.cmd [[ enew ]]
        end,
        function()
          require("modules.buffer").delete_buffer(bufnum)
        end,
        function()
          vim.cmd [[ bwipe ]]
        end,
        function() end,
        function()
          vim.cmd [[ let @* = expand("%:p") ]]
        end,
        function()
          vim.cmd [[ let @* = expand("%") ]]
        end,
        function() end,
        function()
          vim.cmd("vertical sbuffer " .. bufnum)
        end,
        function()
          vim.cmd("sbuffer " .. bufnum)
        end,
        function()
          require("bufferline").move(1)
        end,
        function()
          require("bufferline").move(-1)
        end,
        function()
          require("bufferline").pick_buffer()
        end,
        function()
          require("bufferline").sort_buffers_by "extension"
        end,
        function()
          require("bufferline").sort_buffers_by "relative_directory"
        end,
        function()
          require("bufferline").sort_buffers_by "directory"
        end,
        function() end,
        function()
          require("bufferline").cycle(1)
        end,
        function()
          require("bufferline").cycle(-1)
        end,
      }

      require("contextmenu").open(choises, {
        callback = function(chosen)
          local choise_func = choise_callbacks[chosen]

          if choise_func == nil then
            return
          end

          return choise_func()
        end,
      })
    end,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict)
      local s = ""

      for e, n in pairs(diagnostics_dict) do
        local sym = (e == "error" and "  ") or (e == "warning" and "  " or "  ")

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
    custom_areas = {
      right = function()
        local result = {}
        local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

        if error ~= 0 then
          result[1] = { text = "  " .. error, guifg = "#db4b4b" }
        end

        if warning ~= 0 then
          result[2] = { text = "  " .. warning, guifg = "#e0af68" }
        end

        if info ~= 0 then
          result[4] = { text = "  " .. info, guifg = "#0db9d7" }
        end

        if hint ~= 0 then
          result[3] = { text = "  " .. hint, guifg = "#a0c980" }
        end

        return result
      end,
    },
    show_close_icon = false,
    separator_style = "thin",
    offsets = {
      { filetype = "NvimTree", text = O.japanese and "エクスプローラー" or "Explorer", text_align = "center" },
      { filetype = "dbui", text = O.japanese and "データベース" or "DBUI", text_align = "center" },
      { filetype = "Outline", text = O.japanese and "シンボル" or "Symbols", text_align = "center" },
      {
        filetype = "UltestSummary",
        text = O.japanese and "テスト エクスプローラー" or "Test Explorer",
        text_align = "center",
      },
    },
  },
  highlights = {
    fill = { guibg = "#282c34" },
    separator_selected = { guibg = "#282c34" },
    buffer_selected = { gui = "italic" },
    info = { guifg = "#0db9d7" },
    info_selected = { guifg = "#0db9d7", guisp = "#0db9d7" },
    info_diagnostic = { guisp = "#0db9d7" },
    info_diagnostic_selected = { guifg = "#0db9d7", guisp = "#0db9d7" },
    warning = { guifg = "#e0af68" },
    warning_selected = { guifg = "#e0af68", guisp = "#e0af68" },
    warning_diagnostic = { guisp = "#e0af68" },
    warning_diagnostic_selected = { guifg = "#e0af68", guisp = "#e0af68" },
    error = { guifg = "#db4b4b" },
    error_selected = { guifg = "#db4b4b", guisp = "#db4b4b" },
    error_diagnostic = { guisp = "#db4b4b" },
    error_diagnostic_selected = { guifg = "#db4b4b", guisp = "#db4b4b" },
  },
}
