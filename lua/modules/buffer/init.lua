local M = {}

local function get_buffer(bufexpr)
  if not bufexpr then
    return vim.fn.bufnr()
  end

  if tonumber(bufexpr) then
    return tonumber(bufexpr)
  end

  bufexpr = string.gsub(bufexpr, [[^['"]+]], "")
  bufexpr = string.gsub(bufexpr, [[['"]+$]], "")

  return vim.fn.bufnr(bufexpr)
end

local function get_next_buffer(buffer)
  local next = vim.fn.bufnr "#"

  for i = 0, (vim.fn.bufnr "$" - 1) do
    next = (buffer + i) % vim.fn.bufnr "$" + 1

    if vim.fn.buflisted(next) == 1 then
      return next
    end
  end
end

local function switch_buffer(windows, buffer)
  local winnr = vim.fn.winnr()

  for _, winid in ipairs(windows) do
    vim.cmd(vim.fn.win_id2win(winid) .. " wincmd w")
    vim.cmd("buffer " .. buffer)
  end

  vim.cmd(winnr .. " wincmd w")
end

function M.delete_buffer(bufexpr)
  local buflisted = vim.fn.getbufinfo {
    buflisted = 1,
  }

  if #buflisted < 2 then
    vim.cmd "confirm qall"

    return
  end

  local buffer = get_buffer(bufexpr)

  if vim.fn.buflisted(buffer) == 0 then
    return
  end

  local next_buffer = get_next_buffer(buffer)
  local windows = vim.fn.getbufinfo(buffer)[1].windows

  switch_buffer(windows, next_buffer)

  if vim.fn.getbufvar(buffer, "&buftype") == "terminal" then
    vim.cmd("bd! " .. buffer)
  else
    vim.cmd("silent! confirm bd " .. buffer)
  end

  if vim.fn.buflisted(buffer) == 1 then
    switch_buffer(windows, buffer)
  end
end

return M
