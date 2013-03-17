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

  getFolder: (id, cb) ->
    @get 'getMusicDirectory', { id }, (response) ->
      cb null, response.directory.child

module.exports = Subsonic
