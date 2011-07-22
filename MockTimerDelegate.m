#import "MockTimerDelegate.h"

@implementation MockTimerDelegate

@synthesize remainingTimeDidChangeWasCalled, remainingTimeDidChangeCalledWith, count, timerEndedCalled;

-(id) init {
    if ((self = [super init])) {
        remainingTimeDidChangeWasCalled = NO;
        timerEndedCalled = NO;
        count = 0;
    }
    return self;
}

-(void) remainingTimeDidChange: (NSNumber*) remainingSeconds {
    remainingTimeDidChangeWasCalled = YES;
    self.remainingTimeDidChangeCalledWith = remainingSeconds;
    count = count + 1;
}

-(void) timerEnded {
    timerEndedCalled = YES;
}

-(NSNumber*) remainingTimeDidChangeWasCalledTimes {
    return [NSNumber numberWithInt: count];
}

-(void) dealloc {
    [remainingTimeDidChangeCalledWith release];
    [super dealloc];
}

@end
