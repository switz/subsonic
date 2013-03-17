request = require 'superagent'

class Subsonic
  constructor: (@config) ->
    { @username, @password, @server, @application, @format, @version } = @config
    @application ||= 'subsonic node.js api'
    @format ||= 'json'
    @version ||= '1.7'

  get: (path, query, cb) ->
    cb = arguments[arguments.length - 1]

    request.get("#{@server}/#{path}.view")
      .query('u': @username, 'p': @password)
      .query('c': @application, 'v': @version, 'f': @format)
      .query(query unless typeof query is 'function')
      .end (res) ->
        cb res.body['subsonic-response']

  ping: (cb) ->
    @get 'ping', (response) ->
      cb null, response

  topLevelFolders: (cb) ->
    @get 'getMusicFolders', (res) ->
      cb null, res.musicFolders.musicFolder

  indexes: (cb) ->
    @get 'getIndexes', (res) ->
      cb null, res.indexes.index

  folder: (id, cb) ->
    @get 'getMusicDirectory', { id }, (response) ->
      cb null, response.directory.child

  artists: (cb) ->
    @get 'getArtists', (res) ->
      cb null, res.artists.index

  artist: (id, cb) ->
    @get 'getArtist', { id }, (res) ->
      cb null, res.artist

  album: (id, cb) ->
    @get 'getAlbum', { id }, (res) ->
      cb null, res.album

  song: (id, cb) ->
    @get 'getSong', { id }, (res) ->
      cb null, res.song

  createShare: (id, expires, cb) ->
    if typeof expires is 'function'
      cb = expires.bind {}
      # valid for 1 hour
      expires = (Date.now() / 1000) + 3600
    @get 'createShare', { id, expires }, (res) ->
      cb null, res.shares.share

module.exports = Subsonic
