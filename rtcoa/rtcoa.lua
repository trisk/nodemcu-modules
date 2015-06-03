------------------------------------------------------------------------------
-- RTCOA WiFi API module for NODEMCU
--
-- LICENCE: http://opensource.org/licenses/MIT
-- Albert Lee <trisk@forkgnu.org>
------------------------------------------------------------------------------

-- Set module name as parameter of require
local modname = ...
local M = {}
_G[modname] = M
--------------------------------------------------------------------------------
-- Local used variables
--------------------------------------------------------------------------------
-- thermostat hostname
local tstat = nil
--------------------------------------------------------------------------------
-- Local used modules
--------------------------------------------------------------------------------
-- Net module
local net = net
-- String module
local string = string
-- CJSON module
local cjson = cjson
-- Limited to local environment
setfenv(1,M)

--------------------------------------------------------------------------------
-- Implementation
--------------------------------------------------------------------------------
function open(host)
  tstat = host
end

function set(resource, attributes)
  local js = cjson.encode(attributes)
  if (js == nil) then
    return
  end
  local sk = net.createConnection(net.TCP, false)
  sk:on("connection", function(s)
    s:send("POST /tstat/" .. resource .. " HTTP/1.1\r\n" ..
      "Host: " .. tstat .. "\r\nAccept: */*\r\n" ..
      "Content-Type: application/json\r\n" ..
      "Content-Length: " .. string.len(js) .. "\r\n\r\n" .. js)
  end)
  sk:on("receive", function(s, p)
    s:close()
  end)
  sk:connect(80, tstat)
end

return M
