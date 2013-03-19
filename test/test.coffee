request = require 'superagent'
expect = require 'expect.js'
nconf = require 'nconf'
require 'coffee-script'

## monkey-patch expect.js for better diffs on mocha
## see: https://github.com/LearnBoost/expect.js/pull/34

origBe = expect.Assertion::be
expect.Assertion::be = expect.Assertion::equal = (obj) ->
  @_expected = obj
  origBe.call this, obj

nconf.argv()
  .env()
  .file(__dirname + '/config.json')

### Subsonic ###
Subsonic = require '../src/subsonic'
subsonic = new Subsonic
  username: nconf.get 'USERNAME'
  password: nconf.get 'PASSWORD'
  server: nconf.get 'SERVER'
  application: 'test'

### Specs ###

describe 'API', ->
  describe 'With proper parameters', ->

    it 'ping', (done) ->
      subsonic.ping (err, res) ->
        expect(err).to.be null
        expect(res.status).to.be 'ok'
        done()

    it 'top level folders', (done) ->
      subsonic.topLevelFolders (err, folders) ->
        expect(err).to.be null
        expect(folders.length).to.be 2
        done()

    it 'indexes', (done) ->
      subsonic.indexes (err, indexes) ->
        expect(err).to.be null
        expect(indexes.length).to.be 25
        done()

    it 'folder', (done) ->
      subsonic.folder 54, (err, folder) ->
        expect(err).to.be null
        expect(folder.children.length).to.be 46
        expect(folder.id).to.be 54
        expect(folder.name).to.be 2012
        done()

    it 'artists', (done) ->
      subsonic.artists (err, artists) ->
        expect(err).to.be null
        expect(artists.length).to.be 25
        done()

    it 'artist', (done) ->
      subsonic.artist 1, (err, artist) ->
        expect(err).to.be null
        expect(artist.id).to.be 1
        expect(artist.album.length).to.be 1633
        done()

    it 'album', (done) ->
      subsonic.album 1568, (err, album) ->
        expect(err).to.be null
        expect(album.id).to.be 1568
        expect(album.song.length).to.be 4
        done()

    it 'song', (done) ->
      subsonic.song 35666, (err, song) ->
        expect(err).to.be null
        expect(song.id).to.be 35666
        expect(song.genre).to.be 'Jamband'
        expect(song.album).to.be '12-29-1997 MSG, NY'
        expect(song.title).to.be 'Down With Disease >'
        done()

    it 'chain', (done) ->
      subsonic.ping((err, res) ->
        expect(res.status).to.be 'ok'
      ).topLevelFolders (err, folders) ->
        expect(folders.length).to.be 2
        done()
