fs = require 'fs'
slugify = require "underscore.string/slugify"

content = fs.readFileSync '/proc/cpuinfo', 'utf8'
cpuinfo = {}
infos = content.split("\n")
for info in infos
    info = info.split ":"
    if info.length is 2
        cpuinfo[slugify(info[0])] = info[1]

console.log cpuinfo
