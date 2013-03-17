request = require 'superagent'
expect = require 'expect.js'
require 'coffee-script'

## monkey-patch expect.js for better diffs on mocha
## see: https://github.com/LearnBoost/expect.js/pull/34

origBe = expect.Assertion::be
expect.Assertion::be = expect.Assertion::equal = (obj) ->
  @_expected = obj
  origBe.call this, obj

### Subsonic ###
config = require './config'
Subsonic = require '../src/subsonic'
subsonic = new Subsonic config

### Specs ###

describe 'API', ->
  describe 'With proper parameters', ->

    it 'getFolder', (done) ->
      subsonic.getFolder 54, (err, folder) ->
        expect(err).to.be null
        expect(folder.length).to.be 46
        done()

    it 'getFolder', (done) ->
      subsonic.ping (err, res) ->
        expect(err).to.be null
        expect(res.status).to.be 'ok'
        done()
