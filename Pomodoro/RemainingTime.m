#import "RemainingTime.h"

@implementation RemainingTime

@synthesize duration, startingTime;

+(NSString*) stringFormatForDuration:(int) duration {
    return [NSString stringWithFormat: @"%d:%02d", duration / 60, duration % 60];
}

+(id) startWithDuration:(int)duration target:(id)target selector:(id)selector {
    return [[RemainingTime alloc] initWithDuration: duration];
}

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

-(void) dealloc {
    [duration release];
    [startingTime release];
    [super dealloc];
}

@end
