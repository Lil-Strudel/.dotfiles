hl.config({
    input = {
        repeat_rate  = 50,
        repeat_delay = 250,
    },
    cursor = {
        hide_on_key_press = true,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
