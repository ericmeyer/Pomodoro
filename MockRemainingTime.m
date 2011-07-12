#import "MockRemainingTime.h"

@implementation MockRemainingTime

@synthesize totalSecondsRemaining, duration;

-(id) init {
    if ((self = [super init])) {
        self.totalSecondsRemaining = 0;
    }
    return self;
}

-(void) startAt: (NSDate*) givenTime {
    //Do nothing
}

-(int) totalSecondsRemainingAt:(NSDate*) givenTime {
    return totalSecondsRemaining;
}

-(BOOL) isOverAt:(NSDate*) givenTime {
    if ((self.totalSecondsRemaining <= 0)) {
        return YES;
    } else {
        return NO;
    }
}

@end
