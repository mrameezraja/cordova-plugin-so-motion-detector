#import "CDVSOMotionDetector.h"
#import <Cordova/CDV.h>
#import "SOMotionDetector.h"
#import "SOStepDetector.h"

@interface CDVSOMotionDetector ()
{
    int stepCount;
}
@end

@implementation CDVSOMotionDetector

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


- (void)start:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSMutableDictionary *options = [command argumentAtIndex:0];
        [SOMotionDetector sharedInstance].motionTypeChangedBlock = ^(SOMotionType motionType) {
            NSString *type = @"";
            switch (motionType) {
                case MotionTypeNotMoving:
                    type = @"stopped";
                    break;
                case MotionTypeWalking:
                    type = @"walking";
                    break;
                case MotionTypeRunning:
                    type = @"running";
                    break;
                case MotionTypeAutomotive:
                    type = @"automotive";
                    break;
            }
            NSLog(@"type: %@", type);
            //NSMutableDictionary* returnInfo = [NSMutableDictionary dictionaryWithCapacity:4];
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: type];
            [result setKeepCallbackAsBool:true];
            [self.commandDelegate sendPluginResult:result callbackId: command.callbackId];
        };
        
        [SOMotionDetector sharedInstance].locationChangedBlock = ^(CLLocation *location) {
            //[NSString stringWithFormat:@"%.2f km/h",[SOMotionDetector sharedInstance].currentSpeed * 3.6f];
        };
        
        [SOMotionDetector sharedInstance].accelerationChangedBlock = ^(CMAcceleration acceleration) {
            BOOL isShaking = [SOMotionDetector sharedInstance].isShaking;
            //isShaking ? @"shaking":@"not shaking";
        };
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            //[SOMotionDetector sharedInstance].useM7IfAvailable = YES; //Use M7 chip if available, otherwise use lib's algorithm
        }
        
        //This is required for iOS > 9.0 if you want to receive location updates in the background
        //[SOLocationManager sharedInstance].allowsBackgroundLocationUpdates = YES;
        
        //Starting motion detector
        [[SOMotionDetector sharedInstance] startDetection];
        
        //Starting pedometer
        [[SOStepDetector sharedInstance] startDetectionWithUpdateBlock:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                return;
            }
            
            stepCount++;
            //[NSString stringWithFormat:@"Step count: %d", stepCount];
        }];
    }];
}

- (void)stop:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        
        [[SOMotionDetector sharedInstance] stopDetection];
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @""];
        [self.commandDelegate sendPluginResult:result callbackId: command.callbackId];
        
    }];
}

@end
