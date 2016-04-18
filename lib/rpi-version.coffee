cpuinfo = require 'cpuinfo'

cpuinfo.on 'update', (d) ->
    console.log(d)
    
cpuinfo.update()
