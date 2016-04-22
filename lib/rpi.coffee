fs = require 'fs'
yaml = require 'js-yaml'
Hardware = require './hardware'
moment = require 'moment'
_ = require 'lodash'
debug = require('debug') 'rpi-info:rpi'

class RPI
    hardware: null
    versions: null
    revision: null
    infos: {}

    constructor: (revision = null, hardware = null, versions = null) ->
        hardware ?= new Hardware()
        versions ?= yaml.safeLoad fs.readFileSync(__dirname+'/../versions.yml', 'utf8')
        revision ?= hardware.getRevision()

        @setHardware hardware
        @setVersions versions
        @setRevision revision

    setRevision: (@revision) ->
    getRevision: ->
        @revision

    setHardware: (@hardware) ->
    getHardware: ->
        @hardware

    setVersions: (@versions) ->
    getVersions: ->
        return @versions

    getField: (name) ->
        infos = @getInfos()

        if infos? and infos[name]?
            infos[name]
        else
            null

    getVersion: ->
        @getField "version"

    getModel: ->
        @getField "model"

    getReleaseDate: ->
        @getField "releaseDate"

    getAllRevisions: ->
        @getField "revisions"

    checkDate: (date, message) ->
        if not moment(date).isValid()
            throw new Error()

    isReleasedChecks: (date) ->
        releasedDate = @getReleaseDate()
        debug "releasedDate", releasedDate
        @checkDate releasedDate, 'No release date for this RPI'
        @checkDate date, 'Provided date is invalid'

    isReleasedBefore: (date) ->
        @isReleasedChecks date
        moment(@getReleaseDate()).isBefore date

    isReleasedAfter: (date) ->
        @isReleasedChecks date
        moment(@getReleaseDate()).isAfter date

    isUnknown: ->
        not @getInfos()?

    getInfos: ->
        revision = @getRevision()

        if not revision?
            debug 'No revision found'
            return null

        if not @infos[revision]?
            @infos[revision] = _.find @getVersions(), {revisions: [revision]}

        if @infos[revision]?
            @infos[revision]
        else
            null

module.exports = RPI
