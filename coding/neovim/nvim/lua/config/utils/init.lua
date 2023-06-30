local M = {}

local LOG_FILE_PATH = "./tmp/nvim.local.log"
local log_file = io.open(LOG_FILE_PATH, "a")
local log_count = 0

M.sampled_logger = function(message, payload)
  log_count = log_count + 1
  if log_count == 30 then
    log_count = 0
    M.logger(message, payload)
  end
end

M.logger = function(message, payload)
  if log_file == nil then
    return
  end
  if payload ~= nil then
    message = message .. vim.inspect(payload)
  end
  io.output(log_file)
  io.write(message .. "\n")
  log_file:flush()
end

M.set_window_title = function()
  local path = vim.split(vim.fn.getcwd(), "/", {})
  vim.opt.titlestring = [[%{v:progname}: ]] .. vim.fn.join({ path[#path - 1], path[#path] }, "/")
  vim.opt.title = true
end

-- Insert values into a list if they don't already exist
---@param list string[]
---@param values string|number|string[]|number[]|table[]
function M.list_insert_unique(list, values)
  list = list or {}
  if type(values) ~= "table" then
    values = { values }
  end
  for _, value in ipairs(values) do
    if
      not vim.tbl_contains(list, function(tv)
        return vim.deep_equal(tv, value)
      end, { predicate = true })
    then
      table.insert(list, value)
    end
  end
  return list
end

M.get_wakatime_time = function()
  local async = require("plenary.async")
  local Job = require("plenary.job")

  local tx, rx = async.control.channel.oneshot()
  local ok, job = pcall(Job.new, Job, {
    command = os.getenv("HOME") .. "/.wakatime/wakatime-cli",
    args = { "--today" },
    on_exit = function(j, _)
      tx(j:result()[1] or "")
    end,
  })
  if not ok then
    print("Bad WakaTime call: " .. job)
    return ""
  end

  -- if data then return "🅆  " .. data:sub(1, #data - 2) .. " " end
  job:start()
  return rx()
end

M.logger("\n==new-session==\n")

return M
