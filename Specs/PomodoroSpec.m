#import "OCDSpec/OCDSpec.h"
#import "Pomodoro.h"

CONTEXT(Pomodoro)
{
    describe(@"Pomodoro",
        it(@"has a duration", 
            ^{
                Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
                [expect(pomo.duration) toBeEqualTo: [NSNumber numberWithInt: 25*60]];
            }),
        it(@"ticks off 10 minutes",
           ^{
               Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
               NSDate* now = [NSDate date];
               NSDate* ten_minutes_later = [NSDate dateWithTimeInterval: (10*60) sinceDate: now];
               [pomo startAt: now];
               [expect([pomo remainingTimeAt: ten_minutes_later]) toBeEqualTo: [NSNumber numberWithInt: 15*60]];
           }),
             
            nil);
}