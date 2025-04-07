#!/usr/bin/env lua
-- ========================{HEADER}========================|
-- AUTHOR: wellyton 'welly' <welly.tohn@gmail.com> 
-- DESCRIPTION: configurator, but in lua
-- PROGNAME: configure.lua 
-- LICENSE: MIT
-- ========================{ END }========================|

-- import tlib
package.path = package.path .. string.format(";./%s/?.lua", "include/tlib")

-- I'm proud about how this lib makes my work simplier  
local tlib = require("tlib")

local d = tlib.import("include/lua-dialog/dialog")

local installfile
local cache = "/var/cache/tortoise"
local log = "/var/log/tortoise"
local progressfile = "/var/cache/tortoise/progress"

local function help() print(string.format([[
%s {OPTION}
options:
    h | help
    u | update
    f | file
    d | dotfiles (TODO)

    NOTE: (-) or (--) before commands is optional
   ]], arg[0]))
end

function TODO()
   print("THIS FEATURE IS NOT IMPLEMENTED YET")
end

local function update()
   TODO()
end
local function file()
   TODO()
end
local function dotfiles()
   TODO()
end

-- code stolen from lua-dialog/examples.lua

function inputbox(txt, h, w)
   h = h or 0
   w = w or 0
   return d.inputbox(txt, h, w)
end

function passwordbox(txt, h, w)
   h = h or 0
   w = w or 0
   return d.passwordbox(txt, h, w)
end

-- I can rename inputbox to input too and everything will work fine too
local function input(msg)
   result, success, exit_code = inputbox(msg)
   return result
end

-- install information

local installinfo = {}

if #arg == 0 then

   -- I As you can see, things in lua are so absolutely simple
   -- that I didn't even need to change some parts of the code to make everything work.
   print("lets start configuration")
   installinfo.EFI        =   input("EFI: ")
   installinfo.SWAP       =   input("SWAP: ")
   installinfo.ROOT       =   input("ROOT: ")
   installinfo.KEYBOARD   =   input("SET KEYBOARD: ")
   installinfo.ENCODING   =   input("SET ENCODING: ")
   installinfo.ZONEINFO   =   input("SET ZONEINFO: ")
   installinfo.HOSTNAME   =   input("SET HOSTNAME: ")
   installinfo.ROOTPASSWD =   passwordbox("SET ROOT PASSWORD: ")
   installinfo.USERNAME   =   input("SET USERNAME: ")
   installinfo.USERPASSWD =   passwordbox("SET USER PASSWORD: ")

   -- TODO: need to ensure that the information will be written in order
   for k,v in pairs(installinfo) do
      local info = k .. "=\"" .. v .. "\""
      tlib.write_file("install-lua-test.conf", "a", info .. "\n")
   end

   -- TODO: Make this don't ask for information already in configuration file, like sh version
else
   for i in ipairs(arg) do
      -- new arg template
      -- tlib.check_args(arg[i], {'', '-', '', '--'}, func)

      tlib.check_args(arg[i], {'h', '-h', 'help', '--help'}, help)
      tlib.check_args(arg[i], {'u', '-u', 'update', '--update'}, update)
      tlib.check_args(arg[i], {'f', '-f', 'file', '--file'}, file)
      tlib.check_args(arg[i], {'d', '-d', 'dotfiles', '--dotfiles'}, dotfiles)
   end
end
