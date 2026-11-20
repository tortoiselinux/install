-- ========================{HEADER}========================|
-- AUTHOR: wellyton 'welly' <welly.tohn@gmail.com>
-- DESCRIPTION: dialog bidings for lua
-- LIBNAME: Dialog
-- LICENSE: MIT
-- ========================{ END }========================|

--[[ NOTES:
   All of the bidings are interfaces to dialog cmd.

   The symbol _ is used when a dialog window don't
   return nothing or the value returned is not relevant

   The most significant value is returned first
]]

package.path = package.path .. string.format(";./%s/?.lua", "include/tlib")

local t = require("tlib")

local dialog = {}

function dialog.help()
   print(t.exec("dialog --help"))
end

function dialog.hello()
   local out = t.exec("dialog","--clear", "--msgbox", "'Hello, World!'", 0, 0)
end

--yesno        <text> <height> <width>
function dialog.yesno(txt, height, width)
   height = height or 0
   width = width or 0

   local _, success, exit_code = t.run(string.format("dialog --stdout --yesno '%s'", txt), height, width)
   if exit_code == 1 then
      os.exit(1)
   end
   return success, exit_code, _
end

--inputbox     <text> <height> <width> [<init>]
function dialog.inputbox(txt, height, width)
   height = height or 0
   width = width or 0

   local  result, success, exit_code = t.run(string.format("dialog --stdout --inputbox '%s'", txt), height, width)
   if exit_code == 1 then
      os.exit(1)
   end
   return result, success, exit_code
end

--passwordbox  <text> <height> <width> [<init>]
function dialog.passwordbox(txt, height, width)
   height = height or 0
   width = width or 0

   local result, success, exit_code = t.run(string.format("dialog --stdout --passwordbox '%s'", txt), height, width)
   if exit_code == 1 then
      os.exit(1)
   end
   return result, success, exit_code
end

--checklist    <text> <height> <width> <list height> <tag1> <item1> <status1>...
function dialog.checklist(txt, height, width, list_height, ...)
   height = height or 0
   width = width or 0
   list_height = list_height or 0
   items = t.parse_args(...)
   cmd = string.format("dialog --stdout --checklist '%s' %d %d %d %s", txt, height, width, list_height, items)
   local result, sucess, exit_code = t.run(cmd)
   return result, success, exit_code
end

--pause        <text> <height> <width> <seconds>
function dialog.pause(txt, height, width, secods)
   height = height or 0
   width = width or 0
   seconds = seconds or 10
   _, success, exit_code = t.run(string.format("dialog --stdout --title '%s' --pause ''", txt), height, width, seconds)

   return sucess, exit_code, _
end
return dialog
