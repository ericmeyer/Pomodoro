#import "RemainingTime.h"

@implementation RemainingTime

@synthesize duration, startingTime, pauseTime, resumeTime, elapsedPauseTime;

+(NSString*) stringFormatForDuration:(int) duration {
    return [NSString stringWithFormat: @"%d:%02d", duration / 60, duration % 60];
}

-(id) initWithDuration: (int) givenDuration {
    if ((self = [super init])) {
        self.duration = [NSNumber numberWithInt: givenDuration];
        self.startingTime = [NSDate date];
        self.elapsedPauseTime = 0;
    }
    return self;
}

-(void) pauseAt:(NSDate*) givenTime {
    self.pauseTime = givenTime;
}

-(void) resumeAt:(NSDate*) givenTime {
    elapsedPauseTime += [givenTime timeIntervalSinceDate: pauseTime];
    [pauseTime release];
    pauseTime = nil;
}

-(NSNumber*) remainingSecondsAt:(NSDate *)givenTime {
    NSTimeInterval elapsedTime;
    if (pauseTime) {
        elapsedTime = [pauseTime timeIntervalSinceDate: startingTime];
    } else {
        elapsedTime = [givenTime timeIntervalSinceDate: startingTime];
    }
    return [NSNumber numberWithInt: [duration intValue] - (elapsedTime - elapsedPauseTime)];
}

-(void) dealloc {
    [duration release];
    [pauseTime release];
    [resumeTime release];
    [startingTime release];
    [super dealloc];
}

@end
