#import "RemainingTime.h"

@implementation RemainingTime

@synthesize duration, startingTime;

+(NSString*) stringFormatForDuration:(int) duration {
    return [NSString stringWithFormat: @"%d:%02d", duration / 60, duration % 60];
}

-(id) initWithDuration: (int) givenDuration {
    if ((self = [super init])) {
        self.duration = [NSNumber numberWithInt: givenDuration];
        self.startingTime = [NSDate date];
    }
    return self;
}

-(NSNumber*) remainingSecondsAt:(NSDate *)givenTime {
    NSTimeInterval elapsedTime = [givenTime timeIntervalSinceDate: startingTime];
    return [NSNumber numberWithInt: [duration intValue] - elapsedTime];
}

-(void) dealloc {
    [duration release];
    [startingTime release];
    [super dealloc];
}

@end
