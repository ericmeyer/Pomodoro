#import "OCDSpec/OCDSpec.h"
#import "RemainingTime.h"

CONTEXT(remainingTime)
{
    describe(@"remainingTime",
        it(@"has a duration", 
            ^{
                RemainingTime* remainingTime = [[[RemainingTime alloc] initWithDuration: 12345] autorelease];
                [expect(remainingTime.duration) toBeEqualTo: [NSNumber numberWithInt: 12345]];
            }),
        it(@"has a starting time",
           ^{
               RemainingTime* remainingTime = [[[RemainingTime alloc] initWithDuration: 123] autorelease];
               expectFalse(remainingTime.startingTime == nil);
           }),
        it(@"has seconds remaining",
           ^{
               RemainingTime* remainingTime = [[[RemainingTime alloc] initWithDuration: 300] autorelease];
               NSDate* now = [NSDate date];
               NSDate* later = [NSDate dateWithTimeInterval: 125 sinceDate: now];
               remainingTime.startingTime = now;
               [expect([NSNumber numberWithInt: [remainingTime remainingSecondsAt: later]])
                                   toBeEqualTo: [NSNumber numberWithInt: 175]];
           }),
        it(@"has a formatted time left for double digit seconds",
           ^{
               [expect([RemainingTime stringFormatForDuration: 19*60+35]) toBeEqualTo: @"19:35"];
           }),
        it(@"has a formatted time left for single digit seconds",
           ^{
               [expect([RemainingTime stringFormatForDuration: 14*60+5]) toBeEqualTo: @"14:05"];
           }),
        nil);
}