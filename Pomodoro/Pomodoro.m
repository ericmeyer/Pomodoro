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

-(NSNumber*) remainingTimeAt:(NSDate *)givenTime {
    NSTimeInterval elapsedTime = [givenTime timeIntervalSinceDate: startingTime];
    double remainingTime = [duration doubleValue] - elapsedTime;
    return [NSNumber numberWithDouble: remainingTime];
}

@end
