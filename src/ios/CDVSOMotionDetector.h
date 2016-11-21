

#import <Cordova/CDVPlugin.h>

@interface CDVSOMotionDetecter : CDVPlugin

- (void)start:(CDVInvokedUrlCommand*)command;
- (void)stop:(CDVInvokedUrlCommand*)command;

@end
