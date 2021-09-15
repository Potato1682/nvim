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

local function is_valid_buffer(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buflisted")
end

local function is_file_buffer(bufnr)
  return is_valid_buffer(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "terminal"
end

local function get_active_buffers()
  local buffers = vim.api.nvim_list_bufs()
  local active_buffers = {}
  local count = 0

  for _, bufnr in pairs(buffers) do
    if is_file_buffer(bufnr) then
      count = count + 1
      active_buffers[count] = bufnr
    end
  end

  return active_buffers
end

local function open_buffer(bufnr)
  vim.cmd(("buffer %d"):format(bufnr))
end

local function find_buffer(bufnr, buffer_table)
  for index, table_bufnr in ipairs(buffer_table) do
    if bufnr ==  table_bufnr then
      return index
    end
  end
end

function M.goto(bufnr)
  local active_buffers = get_active_buffers()
  local selected_buffer = active_buffers[bufnr]

  if selected_buffer then
    open_buffer(bufnr)
  end
end

function M.next()
  local active_buffers = get_active_buffers()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local total_buffers = table.maxn(active_buffers)
  local buffer_index = find_buffer(current_bufnr, active_buffers)

  if buffer_index == nil then
    buffer_index = 0
  end

  local next_buffer_index = (buffer_index + 1) % (total_buffers + 1)

  if next_buffer_index == 0 then
    next_buffer_index = 1
  end

  M.goto(next_buffer_index)
end

function M.previous(buffer)
  local active_buffers = get_active_buffers()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local total_buffers = table.maxn(active_buffers)
  local buffer_index = find_buffer(current_bufnr, active_buffers)

  if buffer_index ==  nil then
    buffer_index = 0
  end

  local previous_buffer_index = (buffer_index - 1) % (total_buffers + 1)

  if previous_buffer_index == 0 then
    previous_buffer_index = total_buffers
  end

  M.goto(previous_buffer_index)
end

function M.delete(bufexpr)
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
