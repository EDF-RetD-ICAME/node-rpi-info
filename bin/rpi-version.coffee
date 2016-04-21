#!/usr/bin/env coffee
RPI = require '..'
program = require 'commander'
colors = require 'colors'
util = require 'util'
debug = require('debug') 'rpi-version:bin'
moment = require 'moment'
argv = require('yargs').argv

formatField = (field, value) ->
    if program.silent
        if value? and value.toString?
            value = value.toString()

        output = value
    else
        value = util.inspect(value, {depth: 4, colors: true})
        output = "#{field.grey} : #{value}"

    return output

out = (field, value) ->
    console.log formatField(field, value)

all = ->
    rpi = new RPI(program.revision)
    if program.silent
        return console.log rpi.getInfos()

    if rpi.isUnknown()
        return console.log "This RaspberryPi is unknown".red

    output = "RaspberryPi ".grey
    output += "#{rpi.getVersion()}".green
    output += " Model ".grey
    output += "#{rpi.getModel()}".green
    output += " released ".grey
    output += moment(rpi.getReleaseDate()).format('[Q]Q YYYY').green
    console.log output

    out "Revision", rpi.getRevision()
    out "All revisions availables for this kind of device", rpi.getAllRevisions()


program
    .version require('../package').version
    .option '-r, --revision [value]', 'Revision'
    .option '-s, --silent', 'Display raw information only'

program
    .command 'field <field>'
    .alias 'f'
    .description '[version, model, releaseDate, revisions]'
    .action (field) ->
        rpi = new RPI(program.revision)
        out field, rpi.getField(field)

program
    .command 'after <date>'
    .alias 'a'
    .description 'Check if this raspberry pi is released after the given date'
    .action (date) ->
        rpi = new RPI(program.revision)
        out "released after \"#{date}\"", rpi.isReleasedAfter(date)

program
    .command 'before <date>'
    .alias 'b'
    .description 'Check if this raspberry pi is released before the given date'
    .action (date) ->
        rpi = new RPI(program.revision)
        out "released before \"#{date}\"", rpi.isReleasedBefore(date)

program
    .command 'unknown'
    .alias 'u'
    .description 'Check if this raspberry pi has a recognized hardware revision'
    .action ->
        rpi = new RPI(program.revision)
        out "unknown", rpi.isUnknown()

program
    .command 'all'
    .description 'Show all available infos for this raspberry pi'
    .action all

program.parse(process.argv)

all() if argv._.length is 0
