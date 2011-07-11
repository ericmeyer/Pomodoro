#import <Foundation/Foundation.h>

@protocol PomodoroProtocol <NSObject>

-(void) startAt: (NSDate*) givenTime;
-(NSNumber*) minutesRemainingAt: (NSDate*) givenTime;
-(NSNumber*) secondsRemainingAt: (NSDate*) givenTime;

-(NSString*) stringFormatTimeLeftAt: (NSDate*) givenTime;

-(BOOL) isOverAt:(NSDate*) givenTime;

@end
