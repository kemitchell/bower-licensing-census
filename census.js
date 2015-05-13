var fs = require('fs');
var path = require('path');
var directory = 'packages';
var SEPARATOR = '\t';

fs.readdir(path.join(__dirname, directory), function(error, files) {
  files.forEach(function(filePath) {
    var buffer = '';
    fs.createReadStream(path.join(directory, filePath), {encoding: 'utf8'})
      .on('data', function(data) {
        buffer += data;
      })
      .on('end', function() {
        if (buffer.length < 1) return;
          console.log([
            filePath,
            'No bower.json'
          ].join(SEPARATOR));
        try {
          var json = JSON.parse(buffer);
          var license = json.license;
          if (Array.isArray(license) && license.length === 1) {
            license = license[0];
          }
          if (license.hasOwnProperty('type')) {
            license = license.type;
          }
          console.log([
            filePath,
            JSON.stringify(license || 'No license value')
          ].join(SEPARATOR));
        } catch (e) {
        }
      });
  });
});
