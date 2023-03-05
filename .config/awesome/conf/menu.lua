M = {}

local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

M.main = awful.menu {
  items = {
    { "Terminal", C.terminal },
    { "Browser", C.browser },
    { "Editor", C.editor },
    {
      "Apps",
      {
        { "Files", C.filebrowser },
      },
    },
    {
      "Utilities",
      {},
    },
    {
      "Configure",
      {},
    },
    {
      "Awesome",
      {
        { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "manual", terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awesome.conffile },
        { "restart", awesome.restart },
        { "quit", function() awesome.quit() end },
      }
    }
    {
      "Exit",
      {
        { "Log out", "awesome-client 'awesome.quit()'" },
        { "Power off", "poweroff" },
        { "Restart", "reboot" },
      },
    },
  },
}
