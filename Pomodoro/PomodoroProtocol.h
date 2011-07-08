#import <Foundation/Foundation.h>

@protocol PomodoroProtocol <NSObject>

-(void) startAt: (NSDate*) givenTime;
-(NSNumber*) minutesRemainingAt: (NSDate*) givenTime;
-(NSNumber*) secondsRemainingAt: (NSDate*) givenTime;

@end
