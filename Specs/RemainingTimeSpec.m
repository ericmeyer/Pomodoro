#import "OCDSpec/OCDSpec.h"
#import "RemainingTime.h"

CONTEXT(RemainingTime)
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
               [expect([remainingTime remainingSecondsAt: later]) toBeEqualTo: [NSNumber numberWithInt: 175]];
           }),
        it(@"pauses for 3 seconds", 
           ^{
               RemainingTime* remainingTime = [[[RemainingTime alloc] initWithDuration: 300] autorelease];
               NSDate* now = [NSDate date];
               remainingTime.startingTime = now;
               NSDate* pauseTime = [NSDate dateWithTimeInterval: 125 sinceDate: now];
               NSDate* threeSecondsAfterPause = [NSDate dateWithTimeInterval: 3 sinceDate: pauseTime];
               
               [remainingTime pauseAt: pauseTime];
               NSNumber* remainingSeconds = [remainingTime remainingSecondsAt: threeSecondsAfterPause];
               [expect(remainingSeconds) toBeEqualTo: [NSNumber numberWithInt: 175]];
           }),
        it(@"resumes after a pause",
           ^{
               RemainingTime* remainingTime = [[[RemainingTime alloc] initWithDuration: 60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* pauseTime = [NSDate dateWithTimeInterval: 20 sinceDate: now];
               NSDate* resumeTime = [NSDate dateWithTimeInterval: 10 sinceDate: pauseTime];
               NSDate* later = [NSDate dateWithTimeInterval: 5 sinceDate: resumeTime];
               NSDate* evenLater = [NSDate dateWithTimeInterval: 5 sinceDate: later];

               remainingTime.startingTime = now;
               [remainingTime pauseAt: pauseTime];
               [remainingTime resumeAt: resumeTime];
               
               NSNumber* remainingSeconds = [remainingTime remainingSecondsAt: later];
               [expect(remainingSeconds) toBeEqualTo: [NSNumber numberWithInt: 35]];

               NSNumber* laterRemainingSeconds = [remainingTime remainingSecondsAt: evenLater];
               [expect(laterRemainingSeconds) toBeEqualTo: [NSNumber numberWithInt: 30]];
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