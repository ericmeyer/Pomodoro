#import "Pomodoro.h"

@implementation Pomodoro

@synthesize duration, startingTime;

-(id) initWithDuration: (int) givenDuration {
    if ((self = [super init])) {
        self.duration = [NSNumber numberWithInt: givenDuration];
    }
    return self;
}

-(id) init {
    if ((self == [super init])) {
        self.duration = [NSNumber numberWithInt: 25*60];
    }
    return self;
}

-(void) startAt:(NSDate *)givenTime {
    self.startingTime = givenTime;
}

-(NSNumber*) minutesRemainingAt:(NSDate *)givenTime {
    return [NSNumber numberWithInt: ([self totalSecondsRemainingAt: givenTime] / 60)];
}

-(NSNumber*) secondsRemainingAt:(NSDate *)givenTime {
    return [NSNumber numberWithInt: ([self totalSecondsRemainingAt: givenTime] % 60)];
}

-(BOOL) isOverAt:(NSDate*) givenTime {
    return ([self totalSecondsRemainingAt: givenTime] <= 0);
}

-(int) totalSecondsRemainingAt:(NSDate *)givenTime {
    if (startingTime == nil) {
        return [duration intValue];
    } else {
        NSTimeInterval elapsedTime = [givenTime timeIntervalSinceDate: startingTime];
        return [duration intValue] - elapsedTime;
    }
}

-(NSString*) stringFormatTimeLeftAt: (NSDate*) givenTime {
    return [NSString stringWithFormat: @"%d:%02d",
            [[self minutesRemainingAt: givenTime] intValue],
            [[self secondsRemainingAt: givenTime] intValue]];
}

-(void) dealloc {
    [duration release];
    [startingTime release];
    [super dealloc];
}

@end
