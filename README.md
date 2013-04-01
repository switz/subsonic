subsonic
========

npm module for the subsonic api

[![build status](https://secure.travis-ci.org/switz/subsonic.png)](http://travis-ci.org/switz/subsonic)

### Install

```
$ npm install subsonic --save
```

### Docs
[Documentation](http://saewitz.com/subsonic/doc/classes/Subsonic.html)

### Example

```javascript
var Subsonic = require('subsonic');
var subsonic = new Subsonic({
  username: '',
  password: '',
  server: '',
  application: 'subsonic node.js api', // optional
  format: 'json', // optional
  version: 1.7 // optional
});

subsonic.ping(function(err, res) {
  console.log(res.status);
});
```
