request = require 'superagent'

class Subsonic
  constructor: (@config) ->
    { @username, @password, @server, @application, @format, @version } = @config
    @application ||= 'subsonic node.js api'
    @format ||= 'json'
    @version ||= '1.7'

  request: (path, query, cb) ->
    request.get("#{@server}/#{path}.view")
      .query('u': @username, 'p': @password)
      .query('c': @application, 'v': @version, 'f': @format)
      .query(query)
      .end (res) ->
        cb res.body['subsonic-response'].directory.child

  getFolder: (id, cb) ->
    @request 'getMusicDirectory', { id }, (folder) ->
      cb null, folder

module.exports = Subsonic
