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
        it(@"starts with 25 remaining minutes",
           ^{
               Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
               NSDate* now = [NSDate date];
               [pomo startAt: now];

               [expect([pomo minutesRemainingAt: now]) toBeEqualTo: [NSNumber numberWithInt: 25]];
           }),
        it(@"has seconds left",
           ^{
               Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
               NSDate* now = [NSDate date];
               [pomo startAt: now];
               
               [expect([pomo secondsRemainingAt: now]) toBeEqualTo: [NSNumber numberWithInt: 0]];
           }),
        it(@"ticks off 10 minutes",
           ^{
               Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
               NSDate* now = [NSDate date];
               NSDate* ten_minutes_later = [NSDate dateWithTimeInterval: (10*60) sinceDate: now];
               [pomo startAt: now];
               [expect([pomo minutesRemainingAt: ten_minutes_later]) toBeEqualTo: [NSNumber numberWithInt: 15]];
           }),
        it(@"ticks off 12 seconds",
           ^{
               Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
               NSDate* now = [NSDate date];
               NSDate* twelve_seconds_later = [NSDate dateWithTimeInterval: 12 sinceDate: now];
               [pomo startAt: now];
               [expect([pomo secondsRemainingAt: twelve_seconds_later]) toBeEqualTo: [NSNumber numberWithInt: 48]];
           }),
        it(@"ticks off minutes and seconds",
           ^{
               Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
               NSDate* now = [NSDate date];
               NSDate* ten_minutes_later = [NSDate dateWithTimeInterval: (10*60+35) sinceDate: now];
               [pomo startAt: now];
               [expect([pomo minutesRemainingAt: ten_minutes_later]) toBeEqualTo: [NSNumber numberWithInt: 14]];
               [expect([pomo secondsRemainingAt: ten_minutes_later]) toBeEqualTo: [NSNumber numberWithInt: 25]];
           }),
         it(@"ticks exactly one minute",
            ^{
                Pomodoro* pomo = [[[Pomodoro alloc] init] autorelease];
                NSDate* now = [NSDate date];
                NSDate* one_minute_later = [NSDate dateWithTimeInterval: 60 sinceDate: now];
                [pomo startAt: now];
                [expect([pomo minutesRemainingAt: one_minute_later]) toBeEqualTo: [NSNumber numberWithInt: 24]];
                [expect([pomo secondsRemainingAt: one_minute_later]) toBeEqualTo: [NSNumber numberWithInt: 0]];
            }),
             
            nil);
}