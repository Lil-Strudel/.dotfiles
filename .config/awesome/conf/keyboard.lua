local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")

local modkey = C.modkey or "Mod4"

-- General
awful.keyboard.append_global_keybindings {
    awful.key({ modkey }, "s", hotkeys_popup.show_help, {description="show help", group="awesome"}),
    
    awful.key({ modkey }, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
    
    awful.key({ modkey }, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
    
    awful.key({ modkey }, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),
    
    awful.key({ modkey }, "j",function ()
        awful.client.focus.byidx(1)
    end, {description = "focus next by index", group = "client"}),
    
    awful.key({ modkey }, "k", function ()
        awful.client.focus.byidx(-1)
    end, {description = "focus previous by index", group = "client"}),
    
    awful.key({ modkey }, "w", function () 
        mymainmenu:show() 
    end, {description = "show main menu", group = "awesome"}),
}