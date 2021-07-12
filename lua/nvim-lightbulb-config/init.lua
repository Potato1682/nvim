vim.cmd [[ hi link LightBulbVirtualText Green ]]

require("events").nvim_create_autocmd {
  "CursorMoved,CursorMovedI",
  "*",
  table.concat(
    vim.split(
      [[
        lua require"nvim-lightbulb".update_lightbulb {
          sign = {
            enabled = false
          },
          virtual_text = {
            enabled = true,
            text = " "
          },
          status_text = {
            enabled = true,
            text = " "
          }
        }
      ]],
      "\n"
    ),
    " "
  ),
}
