
cordova-plugin-so-motion
====================

A Cordova plugin that uses `SOMotionDetector` Library (https://github.com/SocialObjects-Software/SOMotionDetector) to detect motion.

Installation
------------

<pre>
  <code>
    cordova plugin add https://github.com/mrameezraja/cordova-plugin-so-motion
  </code>
</pre>


Methods
-------
- cordova.plugins.soMotionDetector.start
- cordova.plugins.soMotionDetector.stop


cordova.plugins.soMotionDetector.requestUpdates
-----------------------------------

<pre>
<code>
  window.cordova.plugins.soMotionDetector.start(function success(status) {
    console.log(status);
    // (output)
    // walking
    // stopped
    // running
    // automotive
  }, function(error){
    console.log(error);
  })
</code>
</pre>

cordova.plugins.soMotionDetector.stop
-----------------------------------

<pre>
<code>
  window.cordova.plugins.soMotionDetector.stop(function success() {
    console.log('motion detection stopped');
  }, function(error){
    console.log(error);
  })
</code>
</pre>

Supported Platforms
-------------------

- IOS
