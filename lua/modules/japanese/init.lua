vim.g.word_eol = 1

_G.MJp = {}

function _G.MJp.eol_movement(command, count)
  local eol = vim.g.word_eol
  local cnt = count - (eol ~= 0 and 1 or 0)

  if cnt > 0 then
    vim.cmd("normal! " .. count .. command)
  end

  if eol == 0 then
    return
  end

  local previous = vim.fn.getpos "."

  vim.cmd("normal! " .. command)

  local post = vim.fn.getpos "."

  if previous[2] ~= post[2] then
    if command == "w" or (command == "e" and vim.opt.virtualedit:get() == "onemore") then
      local character = vim.fn.matchstr(vim.fn.getline(previous[2]), ".$")
      local length = vim.fn.strlen(previous[2])

      length = length + ((vim.opt.virtualedit:get() == "onemore" and eol ~= 2) and 1 or (1 - vim.fn.strlen(character)))

      if previous[3] ~= length then
        previous[3] = length

        vim.fn.setpos(".", previous)
      end
    elseif command == "b" then
      post[3] = vim.fn.col "$" - (eol == 2 and 1 or 0) * vim.fn.strlen(vim.fn.matchstr(vim.fn.getline(post[2]), ".$"))

      vim.fn.setpos(".", post)
    end
  end
end

function _G.MJp.jp_movement(command, count)
  local fn = vim.fn

  local onemore = vim.opt.virtualedit:get() == "onemore"

  local separator = "[、。]"
  local separatorR = "[^、。]"

  local space = "[[:space:]　]"
  local spaceR = "[^[:space:]　]"

  local regexp = ([[\(^]] .. space .. [[*\zs\)\|\(]] .. space .. [[\+\zs\)]])
    .. ([[\|\(]] .. separator .. [[\+\zs\)]])
    .. [[\|$]]

  if fn.eval("'" .. command .. "'" .. " =~ '[nox]E'") == 1 then
    regexp = ([[\(\zs]] .. spaceR .. space .. [[\+\)\|\(\zs]] .. separatorR .. separator .. [[\+\)]])
      .. (fn.eval("'" .. command .. "'" .. " =~ 'nE'") == 1 and [[\|\zs.$]] or [[\|\zs$]])
      .. [[\|^$]]
  elseif fn.eval("'" .. command .. "'" .. " =~ '[nox]B'") == 1 then
    regexp = ([[\(^]] .. spaceR .. [[\)\|\(]] .. space .. [[\+\zs\)\|\(]] .. separator .. [[\+\zs\)]]) .. [[\|$]]
  elseif command == "oW" and fn.eval "v:operator" == "c" then
    regexp = ([[\(]] .. space .. [[\+\zs\)\|\(]] .. spaceR .. [[\zs]] .. space .. [[\+\)\|\(]] .. separator .. [[\+\)]])
      .. [[\|$]]
  end

  local first_position

  if fn.eval("'" .. command .. "'" .. " =~ 'x[WBE]'") == 1 then
    vim.cmd [[normal! gv]]

    local last_position = fn.getpos "."

    vim.cmd [[normal! o]]

    first_position = fn.getpos "."

    vim.cmd [[normal! o]]
    vim.cmd [[normal! v]]

    fn.setpos(".", last_position)
  end

  local saved_virtualedit = vim.opt.virtualedit:get()

  local line_number
  local column

  for _, _ in ipairs(fn.range(count)) do
    local pos = fn.getpos "."

    line_number = pos[2]
    column = pos[3]

    local length = fn.strlen(fn.getline(line_number)) - fn.strlen(fn.matchstr(fn.getline(line_number), ".$"))
    local character = fn.matchstr(fn.getline(line_number), ".", column - 1)

    if fn.eval("'" .. command .. "'" .. " =~ '[nox]E'") == 1 then
      character = fn.matchstr(fn.getline(line_number), ".", column + fn.strlen(character) - 1)
    elseif fn.eval("'" .. command .. "'" .. " =~ '[nox]B'") == 1 then
      character = fn.matchstr(fn.getline(line_number), ".", column - fn.strlen(character) - 1)
    end

    if length ~= 0 and column == length + 1 and onemore then
      fn.cursor(fn.line ".", fn.col "$")

      goto continue
    elseif fn.eval("'" .. character .. "'" .. " =~ '" .. separator .. [[' . '\+ ']]) == 1 and column < length + 1 then
      fn.cursor(line_number, fn.col "." + fn.strlen(character))
    end

    local stopline = fn.eval("'" .. command .. "'" .. " =~ '[nox]B'") == 1
        and fn.line "." - (fn.line "." ~= 1 and 1 or 0)
      or 0
    local flags = (fn.eval("'" .. command .. "'" .. " =~ '[nox]B'") == 1 and "b" or "W") .. (count < 0 and "c" or "")
    local position = fn.search(regexp, flags, stopline)

    if position == 0 and fn.eval("'" .. command .. "'" .. " =~ '[nox]B'") == 1 then
      fn.cursor(fn.line "." - (fn.line "." ~= 1 and 1 or 0), "1")
    end

    ::continue::
  end

  vim.cmd("silent execute 'setlocal virtualedit=" .. saved_virtualedit .. "'")

  if fn.eval("'" .. command .. "'" .. " =~ 'x[WBE]'") then
    local next_position = fn.getpos "."

    fn.setpos(".", first_position)

    vim.cmd [[normal! v]]

    fn.setpos(".", next_position)
  end

  if command == "oE" then
    local character = fn.matchstr(fn.getline(line_number), ".", column - 1)
    character = fn.matchstr(fn.getline(line_number), ".", column + fn.strlen(character) - 1)

    if fn.eval("'" .. character .. "'" .. " !~ " .. "'" .. separator .. "'") == 1 then
      fn.cursor(line_number, fn.col "." + fn.strlen(character))
    end
  end
end

function _G.MJp.jp_object(mode, command, count)
  local saved_virtualedit = vim.opt.virtualedit:get()

  vim.cmd [[set virtualedit+=nemore]]

  for _ in vim.fn.range(count) do
    _G.MJp.jp_object_move(mode, command)
  end

  vim.opt.virtualedit = saved_virtualedit
end

function _G.MJp.jp_object_move(mode, command)
  local fn = vim.fn

  local is_visual = vim.tbl_contains({ "v", "s", "x" }, mode)
  local direction = "w"
  local is_first = true

  local vfline, vlline, vfcol, vlcol

  if is_visual then
    vfline = fn.line "'<"
    vlline = fn.line "'>"
    vfcol = fn.col "'<"
    vlcol = fn.col "'>"

    is_first = (vfline == vlline) and (vfcol == vlcol)
  end

  local space = "[[:space:]　]"
  local is_space = false
  local position_1 = fn.getpos "."

  if is_visual and not is_first then
    vim.cmd [[normal! gv]]

    local direction_pos = fn.getpos "."

    vim.cmd [[normal! v]]

    fn.cursor(vfline, vfcol)

    direction = direction_pos == fn.getpos "." and "b" or "w"

    if direction == "w" then
      fn.cursor(vlline, vlcol)
    end
  else
    if fn.eval("'" .. fn.matchstr(fn.getline ".", ".", fn.col "." - 1) .. "'" .. " =~ '" .. space .. "'") == 1 then
      is_space = true

      fn.search(space .. [[\+]], "cbW", fn.line ".")
    else
      _G.MJp.jp_movement("nW", 1)
      _G.MJp.jp_movement("nB", 1)

      if fn.line "." < position_1[2] then
        fn.cursor(position_1[2], 1)
      end
    end
  end

  position_1 = fn.getpos "."

  if direction == "b" then
    _G.MJp.move_ib()
  elseif direction == "w" then
    if fn.col "." >= fn.col "$" - fn.strlen(fn.matchstr(fn.getline "."), ".$") then
      fn.cursor(fn.line ".", fn.col "$")
    end

    local cursor_position = fn.getpos "."
    local space_position_2

    if
      is_space
      or fn.eval("'" .. fn.matchstr(fn.getline ".", ".", fn.col "." - 1) .. "'" .. " =~ " .. "'" .. space .. "'")
        == 1
    then
      fn.search(space .. [[\+]], "cbW", fn.line ".")

      is_space = is_space or cursor_position ~= fn.getpos "."

      space_position_2 = fn.getpos "."
    end

    if fn.col "$" == 1 and not is_space then
      is_space = fn.search([[^[\r\n]] .. space .. [[\+]], "ceW", fn.line "." + 1) > 0

      space_position_2 = fn.getpos "."
    end

    is_space = is_space and not (is_visual and not is_first)

    local is_one_char = false
    local separator = "[。、]"

    if not (is_visual and not is_first) then
      local length = fn.strlen(fn.matchstr(fn.getline ".", ".", fn.col "." - 1))

      is_one_char = fn.col "." == 1
        or fn.eval(
            "'" .. fn.matchstr(fn.getline ".", ".", fn.col "." - 1 - length) .. "'" .. " =~ " .. "'" .. separator .. "'"
          )
          == 1

      is_one_char = is_one_char
        and (
          fn.col "." == fn.col "$"
          or fn.eval(
            "'" .. fn.matchstr(fn.getline ".", ".", fn.col "." - 1 + length) .. "'" .. " =~ " .. "'" .. separator .. "'"
          )
        )

      if not is_one_char then
        is_one_char = fn.col "." == 1
          or fn.eval(
            "'" .. fn.matchstr(fn.getline ".", ".", fn.col "." - 1 - length) .. "'" .. " =~ " .. "'" .. space .. "'"
          )

        is_one_char = is_one_char
          and (
            fn.col "." == fn.col "$"
            or fn.eval(
              "'" .. fn.matchstr(fn.getline ".", ".", fn.col "." - 1 + length) .. "'" .. " =~ " .. "'" .. space .. "'"
            )
          )
      end
    end

    if is_space then
      fn.setpos(".", space_position_2)
    elseif is_one_char then
      position_1 = fn.col "."

      fn.setpos(".", position_1)
    elseif command == "i" then
      _G.MJp.move_iw()
    elseif command == "a" then
      _G.MJp.move_aw()
    end
  end

  if fn.col "." == fn.col "$" then
    fn.cursor(fn.line ".", fn.col "$" - 1)
  end

  local position_2 = fn.getpos "."

  if is_visual and not is_first then
    vim.cmd [[normal! gv]]
  else
    fn.setpos(".", position_1)

    vim.cmd [[normal! v]]
  end

  fn.setpos(".", position_2)

  vim.cmd [[normal! vgv]]
end

function _G.MJp.move_ib()
  _G.MJp.jp_movement("nB", 1)

  if vim.fn.col "." >= vim.fn.col "$" - 1 then
    _G.MJp.jp_movement("nB", 1)
  end
end

function _G.MJp.move_iw()
  _G.MJp.jp_movement("nE", 1)
end

function _G.MJp.move_aw()
  local fn = vim.fn

  _G.MJp.jp_movement("nE", 1)

  if fn.col "." < fn.col "$" - fn.strlen(fn.matchstr(fn.getline ".", ".$")) then
    _G.MJp.jp_movement("nW", 1)

    if fn.col "." ~= 1 and fn.col "." < fn.col "$" - fn.strlen(fn.matchstr(fn.getline ".", ".$")) then
      vim.cmd [[normal! h]]
    end
  end
end
