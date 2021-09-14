local icons = require "nvim-nonicons"

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
        icons.get "plus-circle" .. " New Buffer        ",
        icons.get "x-circle" .. " Close             ",
        icons.get "x-circle-fill" .. " Close All         ",
        "",
        icons.get "clippy" .. " Copy Path         ",
        icons.get "clippy" .. " Copy Relative Path",
        "",
        icons.get "tmux" .. " Split Vertically  ",
        icons.get "tmux" .. " Split Horizontally",
        icons.get "arrow-right" .. " Move Right        ",
        icons.get "arrow-left" .. " Move Left         ",
        "  Pick Buffers ...  ",
        "  Sort By .extension",
        "  Sort By directory/",
        "  Sort By /directory",
        "",
        icons.get "chevron-right" .. " Select Next Buffer",
        icons.get "chevron-left" .. " Select Prev Buffer",
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
    left_trunc_marker = "",
    right_trunc_marker = "",
    name_formatter = function(buf)
      if buf.name:match "%.md" then
        return vim.fn.fnamemodify(buf.name, ":t:r")
      end
    end,
    custom_filter = function(bufnr)
      if vim.bo[bufnr].buftype == "terminal" then
        return false
      end

      return true
    end,
    custom_areas = {
      right = function()
        local result = {}
        local error = 0
        local warning = 0
        local info = 0
        local hint = 0

        for _, diagnostics in pairs(vim.lsp.diagnostic.get_all()) do
          for _, diagnostic in pairs(diagnostics) do
            severity = diagnostic.severity

            if severity == 1 then
              error = error + 1
            elseif severity == 2 then
              warning = warning + 1
            elseif severity == 3 then
              info = info + 1
            else
              hint = hint + 1
            end
          end
        end

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
      {
        filetype = "NvimTree",
        text = function()
          return O.japanese and "エクスプローラー" or "Explorer" .. " - " .. vim.loop.cwd()
        end,
        highlight = "Blue",
        text_align = "center",
      },
      {
        filetype = "dbui",
        text = O.japanese and "データベース" or "DBUI",
        highlight = "Purple",
        text_align = "center",
      },
      {
        filetype = "Outline",
        text = O.japanese and "シンボル" or "Symbols",
        highlight = "Green",
        text_align = "center",
      },
      {
        filetype = "UltestSummary",
        text = O.japanese and "テスト エクスプローラー" or "Test Explorer",
        highlight = "Purple",
        text_align = "center",
      },
    },
  },
  groups = {
    options = {
      toggle_hidden_on_enter = true,
    },
    items = {
      {
        name = O.japanese and "テスト" or "Tests",
        highlight = { gui = "underline", guisp = "Green" },
        priority = 2,
        icon = icons.get "beaker" .. " ",
        matcher = function(buf)
          return buf.filename:match "%_test" or buf.filename:match "%_spec"
        end,
      },
      {
        name = O.japanese and "ドキュメント" or "Docs",
        highlight = { gui = "underline", guisp = "Blue" },
        icon = icons.get "book" .. " ",
        matcher = function(buf)
          return buf.filename:match "%.md" or buf.filename:match "%.txt" or buf.filename:match "%.rst"
        end,
        separator = {
          style = require("bufferline.groups").separator.tab,
        },
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

function _G.__group_open()
  require("bufferline").group_action(O.japanese and "テスト" or "Tests", function(buf)
    vim.cmd("vsplit " .. buf.path)
  end)
end
