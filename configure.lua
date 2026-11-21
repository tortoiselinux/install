#!/usr/bin/env lua
-- ========================{HEADER}========================|
-- AUTHOR: wellyton 'welly' <welly.tohn@gmail.com> 
-- DESCRIPTION: configurator, but in lua
-- PROGNAME: configure.lua 
-- LICENSE: MIT
-- ========================{ END }========================|

-- import tlib

local tlib   = require("vendor.tlib")
local d      = require("vendor.dialog")

local config = {}
local f,err = loadfile("config.lua", "t", config)
if f then
  f()
else
  print(err)
end

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


-- I can rename inputbox to input too and everything will work fine too
local function input(msg)
  io.write(msg)
  result = io.read()
  return result
end

-- install information

local installinfo = {}

function get(msg, key)
  if key ~= nil then
    print("Found " .. msg .. key)
  else
    local value = input(msg)
    return value
  end
  return nil
end

if #arg == 0 then

   print("lets start configuration")
   config.efi        =   get("efi: ", config.efi)
   config.swap       =   get("swap: ", config.swap)
   config.root       =   get("root: ", config.root)
   config.keyboard   =   get("keyboard: ", config.keyboard)
   config.encoding   =   get("encoding: ", config.encoding)
   config.zoneinfo   =   get("zoneinfo: ", config.zoneinfo)
   config.hostname   =   get("hostname: ", config.hostname)
   config.rootpasswd =   get("root password: ", config.rootpasswd)
   config.username   =   get("username: ", config.username)
   config.userpasswd =   get("user password: ", config.userpasswd)

   -- TODO: need to ensure that the information will be written in order
   for k,v in pairs(config) do
      local info = k .. "=\"" .. v .. "\""
      tlib.write_file("config.lua", "a", info .. "\n")
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
