#import "MockPomodoro.h"

@implementation MockPomodoro

@synthesize minutesRemaining, secondsRemaining;

-(void) startAt: (NSDate*) givenTime {
    //Do nothing
}

-(NSNumber*) minutesRemainingAt: (NSDate*) givenTime {
    return [NSNumber numberWithInt: minutesRemaining];
}

-(NSNumber*) secondsRemainingAt: (NSDate*) givenTime {
    return [NSNumber numberWithInt: secondsRemaining];
}

@end
