-- http://lua-users.org/wiki/StringTrim
local M = {}

M.trim6 = function(s)
  return s:match "^()%s*$" and "" or s:match "^%s*(.*%S)"
end

-- from norcalli/nvim_utils
local nvim_create_augroups = function(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      -- if type(def) == 'table' and type(def[#def]) == 'function' then
      -- 	def[#def] = lua_callback(def[#def])
      -- end
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

local state = {
  initialized = false,
  pid = -1,
  stdin_handle = nil
}

local apply_mode = function(mode)
  if mode == "dark" then
    require("colors.init").reload("gruvbox")
  elseif mode == "light" then
    require("colors.init").reload("one-light")
  end

  state.current_mode = mode
end

local update = function()
  local mode = vim.fn.system("dark-notify --exit")
  mode = M.trim6(mode)
  apply_mode(mode)
end

local set_mode = function(mode)
  mode = M.trim6(mode)
  if not (mode == "light" or mode == "dark") then
    error('mode must be either "light" or "dark"' .. mode)
    return
  end
  apply_mode(mode)
end

M.init_dark_notify = function()
  -- Docs on this vim.loop stuff: https://github.com/luvit/luv

  local handle, pid
  local stdout = vim.loop.new_pipe(false)
  local stdin = vim.loop.new_pipe(false)

  local function onexit()
    vim.loop.close(
      handle,
      vim.schedule_wrap(
        function()
          vim.loop.shutdown(stdout)
          vim.loop.shutdown(stdin)
          state.initialized = false
          state.pid = nil
          state.stdin_handle = nil
        end
      )
    )
  end

  local function onread(err, chunk)
    assert(not err, err)
    if (chunk) then
      local mode = M.trim6(chunk)
      if not (mode == "light" or mode == "dark") then
        error("dark-notify output not expected: " .. chunk)
        return
      end
      apply_mode(mode)
    end
  end

  handle, pid = vim.loop.spawn("dark-notify", {stdio = {stdin, stdout, nil}}, vim.schedule_wrap(onexit))

  vim.loop.read_start(stdout, vim.schedule_wrap(onread))

  state.initialized = true
  state.pid = pid
  state.stdin_handle = stdin

  -- For whatever reason, nvim isn't killing child processes properly on exit
  -- So if you don't do this, you get zombie dark-notify processes hanging about.
  nvim_create_augroups(
    {
      DarkNotifyKillChildProcess = {
        {"VimLeave", "*", "lua require('colors.autodark').stop()"}
      }
    }
  )
end

-- For whatever reason, killing the child process doesn't work, at all. So we
-- send it the line "quit\n", and it kills itself.
M.stop = function()
  if state.stdin_handle == nil then
    return
  end
  vim.loop.write(state.stdin_handle, "quit\n")
  -- process quits itself, calls onexit
  -- config gets edited from there
end

return M
