#import "OCDSpec/OCDSpec.h"
#import "RemainingTime.h"

CONTEXT(ReaminingTime)
{
    describe(@"ReaminingTime",
        it(@"has a duration", 
            ^{
                RemainingTime* reaminingTime = [[[RemainingTime alloc] initWithDuration: 12345] autorelease];
                [expect(reaminingTime.duration) toBeEqualTo: [NSNumber numberWithInt: 12345]];
            }),
        it(@"is not over while time remains",
           ^{
               RemainingTime* reaminingTime = [[[RemainingTime alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               [reaminingTime startAt: now];
               expectFalse([reaminingTime isOverAt: now]);
           }),
        it(@"is over when the exact duration elaspses",
           ^{
               RemainingTime* reaminingTime = [[[RemainingTime alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* end = [NSDate dateWithTimeInterval: [reaminingTime.duration intValue] sinceDate: now];
               [reaminingTime startAt: now];
               expectTruth([reaminingTime isOverAt: end]);
           }),
         it(@"is over more than the duration elapses",
            ^{
                RemainingTime* reaminingTime = [[[RemainingTime alloc] initWithDuration: 25*60] autorelease];
                NSDate* now = [NSDate date];
                NSDate* end = [NSDate dateWithTimeInterval: ([reaminingTime.duration intValue]+100) sinceDate: now];
                [reaminingTime startAt: now];
                expectTruth([reaminingTime isOverAt: end]);
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