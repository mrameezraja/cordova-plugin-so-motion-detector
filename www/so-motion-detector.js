var exec = require('cordova/exec');

var SOMotionDetector = function() { }

SOMotionDetector.prototype = {
  requestUpdates: function(success, error, options){
    exec(success, error, "CDVSOMotionDetecter", "start", [])
  },
  stop: function(success, error, options){
    if(!success)
      success = function(){ }

    if(!error)
      error = function(){ }

    exec(success, error, "CDVSOMotionDetecter", "stop", [])
  }
}

module.exports = new SOMotionDetector();
