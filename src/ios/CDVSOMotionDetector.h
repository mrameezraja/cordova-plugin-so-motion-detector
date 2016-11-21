

#import <Cordova/CDVPlugin.h>

@interface CDVSOMotionDetector : CDVPlugin

- (void)start:(CDVInvokedUrlCommand*)command;
- (void)stop:(CDVInvokedUrlCommand*)command;

@end
