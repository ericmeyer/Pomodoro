#import "Pomodoro.h"

@implementation Pomodoro

@synthesize duration, startingTime;

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

-(int) totalSecondsRemainingAt:(NSDate *)givenTime {
    NSTimeInterval elapsedTime = [givenTime timeIntervalSinceDate: startingTime];
    return [duration intValue] - elapsedTime;
}

-(void) dealloc {
    [duration release];
    [startingTime release];
    [super dealloc];
}
@end
