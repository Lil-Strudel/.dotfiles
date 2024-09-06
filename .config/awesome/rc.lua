-- awesome_mode: api-level=4:screen=on
pcall(require, "luarocks.loader")

local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
require("awful.autofocus")

require "config.error_handling"

_G.theme = "strhuedel"
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "/theme.lua")

require "config"
require "ui"
