#!/usr/bin/env coffee
RPI = require '..'
program = require 'commander'
colors = require 'colors'
util = require 'util'

out = (field, value) ->
    if program.silent
        if value? and value.toString?
            value = value.toString()

        output = value
    else
        value = util.inspect(value, {depth: 4, colors: true})
        output = "#{field.grey} : #{value}"

    console.log output

program
    .version('0.0.1')
    .option('-r, --revision [value]', 'Hardware revision')
    .option('-s, --silent', 'No verbose')

program
    .command('field <field>')
    .action (field) ->
        rpi = new RPI(program.revision)
        out field, rpi.getField(field)

program
    .command 'after <date>'
    .action (date) ->
        rpi = new RPI(program.revision)
        out "released after \"#{date}\"", rpi.isReleasedAfter(date)

program
    .command 'before <date>'
    .action (date) ->
        rpi = new RPI(program.revision)
        out "released before \"#{date}\"", rpi.isReleasedBefore(date)

program
    .command 'unknown'
    .action ->
        rpi = new RPI(program.revision)
        out "unknown", rpi.isUnknown()

program.parse(process.argv)
