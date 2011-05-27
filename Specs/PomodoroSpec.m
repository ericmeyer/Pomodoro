#import "OCDSpec/OCDSpec.h"
#import "Pomodoro.h"

CONTEXT(Pomodoro)
{
    describe(@"Pomodoro should exist",
        it(@"Fails", 
            ^{
                Pomodoro* pomo = [[Pomodoro alloc] init];
                [expect(pomo.duration) toBeEqualTo: [NSNumber numberWithInt: 25]];
            }),

            nil);
}