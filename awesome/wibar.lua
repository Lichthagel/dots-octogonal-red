local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {modkey},
        1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button(
        {modkey},
        3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button(
        {},
        4,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),
    awful.button(
        {},
        5,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    )
)

local tasklist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end
    ),
    awful.button(
        {},
        3,
        function()
            awful.menu.client_list({theme = {width = 250}})
        end
    ),
    awful.button(
        {},
        4,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        {},
        5,
        function()
            awful.client.focus.byidx(-1)
        end
    )
)

function createwibar(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    -- Create a taglist widget
    s.mytaglist =
        awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
        style = {
            shape = function(cr,w,h)
                gears.shape.octogon(cr,w,h,dpi(10))
            end
        },
        widget_template = {
            id = "background_role",
            widget = wibox.container.background,
            forced_height = dpi(32),
            forced_width = dpi(32),
            {
                id = "text_role",
                widget = wibox.widget.textbox,
                forced_width = dpi(32),
                forced_height = dpi(32),
                align = "center"
            }
        }
    }

    -- Create a tasklist widget
    s.mytasklist =
        awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        --widget_template = {

        --},
        layout = {
            spacing = 10,
            layout = wibox.layout.fixed.horizontal
        }
    }

    -- Create the wibox
    s.mywibar =
        awful.wibar(
        {
            position = "top",
            screen = s
        }
    )

    -- Add widgets to the wibox
    s.mywibar:setup {
        {
            spacing = 10,
            layout = wibox.layout.align.horizontal,
            {
                {
                    {
                        -- Left widgets
                        layout = wibox.layout.fixed.horizontal,
                        s.mytaglist,
                        s.mypromptbox
                    },
                    widget = wibox.container.margin,
                    margins = dpi(5)
                },
                widget = wibox.container.background,
                bg = beautiful.bg_normal .. "cc",
                shape = function(cr,w,h)
                    gears.shape.octogon(cr,w,h,dpi(10))
                end
            },
            {
                --s.mytasklist, -- Middle widget
                layout = wibox.layout.flex.horizontal
            },
            {
                {
                    {
                        -- Right widgets
                        layout = wibox.layout.fixed.horizontal,
                        wibox.widget.systray(),
                        pulse,
                        mytextclock,
                        s.mylayoutbox
                    },
                    widget = wibox.container.margin,
                    margins = dpi(5)
                },
                widget = wibox.container.background,
                bg = beautiful.bg_normal .. "cc",
                shape = function(cr,w,h)
                    gears.shape.octogon(cr,w,h,dpi(10))
                end
            }
        },
        top = beautiful.useless_gap,
        left = beautiful.useless_gap*2,
        right = beautiful.useless_gap*2,
        color = "#00000000",
        widget = wibox.container.margin
    }
end

return createwibar
