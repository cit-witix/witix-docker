var config = require('../config');
var httpAuth = require('http-auth');

/*
module.exports = function () {
  var basic;
  if (config.htpasswd) {
    basic = httpAuth.basic({ file: config.htpasswd });
    return httpAuth.connect(basic);
  }
  return function (req, res, next) { return next(); };
};
*/

module.exports = function () {
	var basic = httpAuth.basic({
	        realm: "Web."
	    }, function (username, password, callback) { // Custom authentication method.
	        callback(username === "gpvf" && password === "arquitetura");
	    }
	);
  
  return httpAuth.connect(basic);
};