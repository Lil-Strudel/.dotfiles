require("conf.monitors")
require("conf.autostart")
require("conf.look")
require("conf.layout")
require("conf.input")
require("conf.binds")
require("conf.rules")

local f = io.open("/proc/sys/kernel/hostname")
if f then
    local host = f:read("*l")
    f:close()
    pcall(require, "hosts." .. host)
end
