#!/usr/bin/env lua
-- import tlib
package.path = package.path .. string.format(";./%s/?.lua", "include/tlib")
local tlib = require("tlib")

local installfile
local cache = "/var/cache/tortoise"
local log = "/var/log/tortoise"
local progressfile = "/var/cache/tortoise/progress"

local function help() print([[
$(basename $0) {OPTION}
commands:
   $(basename $0) -{command}
    h | help
    u | update
    f | file
    d | dotfiles (TODO)

    NOTE: (-) or (--) before commands is optional
]])end

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

local function input(msg)
   print(msg)
   return io.read()
end

-- install information

local installinfo = {}

if #arg == 0 then
   print("lets start configuration")
   installinfo.EFI        =   input("EFI: ")
   installinfo.SWAP       =   input("SWAP: ")
   installinfo.ROOT       =   input("ROOT: ")
   installinfo.KEYBOARD   =   input("SET KEYBOARD: ")
   installinfo.ENCODING   =   input("SET ENCODING: ")
   installinfo.ZONEINFO   =   input("SET ZONEINFO: ")
   installinfo.HOSTNAME   =   input("SET HOSTNAME: ")
   installinfo.ROOTPASSWD =   input("SET ROOT PASSWORD: ")
   installinfo.USERNAME   =   input("SET USERNAME: ")
   installinfo.USERPASSWD =   input("SET USER PASSWORD: ")

   -- TODO: need to ensure that the information will be written in order
   for k,v in pairs(installinfo) do
      local info = k .. "=\"" .. v .. "\""
      tlib.write_file("install-lua-test.conf", "a", info .. "\n")
   end
else
   for i in ipairs(arg) do
      -- new arg template
      -- tlib.check_args(arg[i], {'', '-', '', '--'}, func)

      tlib.check_args(arg[i], {'h', '-h', 'help', '--help'}, help)
      tlib.check_args(arg[i], {'u', '-u', 'update', '--update'}, update)
      tlib.check_args(arg[i], {'f', '-f', 'file', '--file'}, file)
      tlib.check_args(arg[i], {'d', '-d', 'dotfiles', '--dotfiles'}, dotfiles)

      tlib.check_args(arg[i], {'ltui'}, ltuitest)
   end
end
