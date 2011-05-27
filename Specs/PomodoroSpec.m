#import "OCDSpec/OCDSpec.h"

CONTEXT(Pomodoro)
{
    describe(@"Pomodoro should exist",
             it(@"Fails", 
                ^{
                    [expect(@"qwe") toBeEqualTo: @"QWE"];
                }),
             
             nil);
}