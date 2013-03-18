subsonic
========

npm module for the subsonic api

### Install

```
$ npm install subsonic --save
```

### Docs
[Documentation](http://saewitz.com/subsonic/doc/classes/Subsonic.html)

### Example

```javascript
Subsonic = require('subsonic');
subsonic = new Subsonic({
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
