#import "MockPomodoro.h"

@implementation MockPomodoro

@synthesize minutesRemaining, secondsRemaining, isOver, formattedTime;

-(void) startAt: (NSDate*) givenTime {
    //Do nothing
}

-(NSNumber*) minutesRemainingAt: (NSDate*) givenTime {
    return [NSNumber numberWithInt: minutesRemaining];
}

-(NSNumber*) secondsRemainingAt: (NSDate*) givenTime {
    return [NSNumber numberWithInt: secondsRemaining];
}

-(NSString*) stringFormatTimeLeftAt: (NSDate*) givenTime {
    return formattedTime;
}

-(BOOL) isOverAt:(NSDate*) givenTime {
    return isOver;
}

@end
