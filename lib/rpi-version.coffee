fs = require 'fs'
s = require "underscore.string"

cpuinfo = ->
    content = fs.readFileSync '/proc/cpuinfo', 'utf8'
    cpuinfo = {}
    infos = content.split("\n")
    for info in infos
        info = info.split ":"
        if info.length is 2
            name = s.slugify s.clean(info[0])
            value = s.clean info[1]
            cpuinfo[name] = value

    return cpuinfo

revision = ->
    infos = cpuinfo()

    if infos.revision?
        infos.revision
    else
        null

console.log revision()
