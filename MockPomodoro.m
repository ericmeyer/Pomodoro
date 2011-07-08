#import "MockPomodoro.h"

@implementation MockPomodoro

@synthesize minutesRemaining, secondsRemaining, isOver;

-(void) startAt: (NSDate*) givenTime {
    //Do nothing
}

-(NSNumber*) minutesRemainingAt: (NSDate*) givenTime {
    return [NSNumber numberWithInt: minutesRemaining];
}

-(NSNumber*) secondsRemainingAt: (NSDate*) givenTime {
    return [NSNumber numberWithInt: secondsRemaining];
}

-(BOOL) isOverAt:(NSDate*) givenTime {
    return isOver;
}

@end
