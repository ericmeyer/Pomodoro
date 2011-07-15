#import "MockRemainingTime.h"

@implementation MockRemainingTime

@synthesize totalSecondsRemaining, duration, wasPauseCalled, wasResumeCalled;

-(id) init {
    if ((self = [super init])) {
        self.totalSecondsRemaining = 0;
        self.wasPauseCalled = NO;
        self.wasResumeCalled = NO;
    }
    return self;
}

-(void) pauseAt:(NSDate *)givenTime {
    self.wasPauseCalled = YES;
}

-(void) resumeAt:(NSDate *)givenTime {
    self.wasResumeCalled = YES;
}

-(NSNumber*) remainingSecondsAt:(NSDate*) givenTime {
    return [NSNumber numberWithInt: totalSecondsRemaining];
}

@end
