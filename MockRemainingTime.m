#import "MockRemainingTime.h"

@implementation MockRemainingTime

@synthesize totalSecondsRemaining, duration;

-(id) init {
    if ((self = [super init])) {
        self.totalSecondsRemaining = 0;
    }
    return self;
}

-(int) remainingSecondsAt:(NSDate*) givenTime {
    return totalSecondsRemaining;
}

@end
