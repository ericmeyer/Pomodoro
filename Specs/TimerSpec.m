#import "OCDSpec/OCDSpec.h"
#import "Timer.h"

CONTEXT(Timer)
{
    describe(@"Timer",
        it(@"has a duration", 
            ^{
                Timer* timer = [[[Timer alloc] initWithDuration: 12345] autorelease];
                [expect(timer.duration) toBeEqualTo: [NSNumber numberWithInt: 12345]];
            }),
        it(@"has 25 remaining minutes",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               [timer startAt: now];

               [expect([timer minutesRemainingAt: now]) toBeEqualTo: [NSNumber numberWithInt: 25]];
           }),
        it(@"has seconds left",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               [timer startAt: now];
               
               [expect([timer secondsRemainingAt: now]) toBeEqualTo: [NSNumber numberWithInt: 0]];
           }),
        it(@"ticks off 10 minutes",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* ten_minutes_later = [NSDate dateWithTimeInterval: (10*60) sinceDate: now];
               [timer startAt: now];
               [expect([timer minutesRemainingAt: ten_minutes_later]) toBeEqualTo: [NSNumber numberWithInt: 15]];
           }),
        it(@"ticks off 12 seconds",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* twelve_seconds_later = [NSDate dateWithTimeInterval: 12 sinceDate: now];
               [timer startAt: now];
               [expect([timer secondsRemainingAt: twelve_seconds_later]) toBeEqualTo: [NSNumber numberWithInt: 48]];
           }),
        it(@"ticks off minutes and seconds",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* ten_minutes_later = [NSDate dateWithTimeInterval: (10*60+35) sinceDate: now];
               [timer startAt: now];
               [expect([timer minutesRemainingAt: ten_minutes_later]) toBeEqualTo: [NSNumber numberWithInt: 14]];
               [expect([timer secondsRemainingAt: ten_minutes_later]) toBeEqualTo: [NSNumber numberWithInt: 25]];
           }),
         it(@"ticks exactly one minute",
            ^{
                Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
                NSDate* now = [NSDate date];
                NSDate* one_minute_later = [NSDate dateWithTimeInterval: 60 sinceDate: now];
                [timer startAt: now];
                [expect([timer minutesRemainingAt: one_minute_later]) toBeEqualTo: [NSNumber numberWithInt: 24]];
                [expect([timer secondsRemainingAt: one_minute_later]) toBeEqualTo: [NSNumber numberWithInt: 0]];
            }),
        it(@"is not over while time remains",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               [timer startAt: now];
               expectFalse([timer isOverAt: now]);
           }),
        it(@"is over when the exact duration elaspses",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* end = [NSDate dateWithTimeInterval: [timer.duration intValue] sinceDate: now];
               [timer startAt: now];
               expectTruth([timer isOverAt: end]);
           }),
         it(@"is over more than the duration elapses",
            ^{
                Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
                NSDate* now = [NSDate date];
                NSDate* end = [NSDate dateWithTimeInterval: ([timer.duration intValue]+100) sinceDate: now];
                [timer startAt: now];
                expectTruth([timer isOverAt: end]);
            }),
        it(@"has a formatted time left for double digit seconds",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* later = [NSDate dateWithTimeInterval: (5*60+25) sinceDate: now];
               [timer startAt: now];
               [expect([timer stringFormatTimeLeftAt: later]) toBeEqualTo: @"19:35"];
           }),
        it(@"has a formatted time left for single digit seconds",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               NSDate* now = [NSDate date];
               NSDate* later = [NSDate dateWithTimeInterval: (10*60+55) sinceDate: now];
               [timer startAt: now];
               [expect([timer stringFormatTimeLeftAt: later]) toBeEqualTo: @"14:05"];
           }),
        it(@"has all of it's time left if it isn't started",
           ^{
               Timer* timer = [[[Timer alloc] initWithDuration: 25*60] autorelease];
               [expect([timer stringFormatTimeLeftAt: [NSDate date]]) toBeEqualTo: @"25:00"];
           }),
            nil);
}