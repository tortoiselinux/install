local ui = {}

ui.black = "\27[1;30m"
ui.red = "\27[1;31m"
ui.green = "\27[1;32m"
ui.yellow = "\27[1;33m"
ui.blue = "\27[1;34m"
ui.magenta = "\27[1;35m"
ui.cyan = "\27[1;36m"
ui.white = "\27[1;37m"

function ui.color(color, text)
    return color .. "" .. text .. "\27[0m"
end

return ui
