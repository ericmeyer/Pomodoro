#import "MockRemainingTime.h"

@implementation MockRemainingTime

@synthesize totalSecondsRemaining, duration;

-(id) init {
    if ((self = [super init])) {
        self.totalSecondsRemaining = 0;
    }
    return self;
}

-(NSNumber*) remainingSecondsAt:(NSDate*) givenTime {
    return [NSNumber numberWithInt: totalSecondsRemaining];
}

@end
