local beautiful = require("beautiful")

function notification(naughty)
    naughty.config.defaults["icon_size"] = beautiful.notification_icon_size

    naughty.config.defaults.timeout = 5
    naughty.config.presets.low.timeout = 2
    naughty.config.presets.critical.timeout = 12

    -- Apply theme variables
    naughty.config.padding = beautiful.notification_padding
    naughty.config.spacing = beautiful.notification_spacing
    naughty.config.defaults.margin = beautiful.notification_margin
    naughty.config.defaults.border_width = beautiful.notification_border_width

    naughty.config.presets.normal = {
        font = beautiful.notification_font,
        fg = beautiful.notification_fg,
        bg = beautiful.notification_bg,
        border_width = beautiful.notification_border_width,
        margin = beautiful.notification_margin,
        position = beautiful.notification_position
    }

    naughty.config.presets.low = {
        font = beautiful.notification_font,
        fg = beautiful.notification_fg,
        bg = beautiful.notification_bg,
        border_width = beautiful.notification_border_width,
        margin = beautiful.notification_margin,
        position = beautiful.notification_position
    }

    naughty.config.presets.ok = naughty.config.presets.low
    naughty.config.presets.info = naughty.config.presets.low
    naughty.config.presets.warn = naughty.config.presets.normal

    naughty.config.presets.critical = {
        font = beautiful.notification_font,
        fg = beautiful.notification_crit_fg,
        bg = beautiful.notification_crit_bg,
        border_width = beautiful.notification_border_width,
        margin = beautiful.notification_margin,
        position = beautiful.notification_position
    }
end

return notification
