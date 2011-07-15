#import "OCDSpec/OCDSpec.h"
#import "Timer.h"
#import "MockTimerDelegate.h"
#import "MockRemainingTime.h"

CONTEXT(Timer)
{
    describe(@"Timer",
             it(@"has a target when started",
                ^{
                    MockTimerDelegate* target = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 target: target selector: nil];
                    
                    [expect(timer.target) toBeEqualTo: target];
                }),
             it(@"has a selector",
                ^{
                    Timer* timer = [Timer startWithDuration: 60 target: nil selector: @selector(someSelector)];
                    expectFalse(timer.selector == nil);
                }),
             it(@"has a valid countdown",
                ^{
                    Timer* timer = [Timer startWithDuration: 10 target: nil selector: @selector(someSelector)];
                    expectTruth([timer.countdown isValid]);
                }),
             it(@"notifies the delegate that time time changes the first check", 
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 target: delegate selector: @selector(someSel)];
                    
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 1]];
                }),
             it(@"passes in the remaining seconds when notifying of time change",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 target: delegate selector: @selector(someSel)];
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 60;

                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeCalledWith) toBeEqualTo: [NSNumber numberWithInt: 60]];
                }),
             it(@"notifies the delegate a second time if the time changes",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 target: delegate selector: @selector(someSel)];
                    
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 60;
                    
                    [timer checkRemainingTime];
                    remainingTime.totalSecondsRemaining = 59;
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 2]];
                }),
             it(@"does not notify the delegate a second time if the time has not changed",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 target: delegate selector: @selector(someSel)];
                    
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 60;
                    
                    [timer checkRemainingTime];
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 1]];
                }),
             it(@"performs the given selector if the time ends",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 target: delegate selector: @selector(timerEnded)];
                    
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 0;

                    [timer checkRemainingTime];
                    
                    expectTruth(delegate.timerEndedCalled);
                }),
             it(@"invalidates the countdown on cancel",
                ^{
                    Timer* timer = [Timer startWithDuration: 10 target: nil selector: @selector(someSelector)];
                    [timer cancel];
                    expectFalse([timer.countdown isValid]);
                }),
             it(@"pauses the timer",
                ^{
                    Timer* timer = [Timer startWithDuration: 60 target: nil selector: nil];
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    
                    [timer pause];
                    
                    expectTruth(remainingTime.wasPauseCalled);
                }),
             it(@"resumes the timer",
                ^{
                    Timer* timer = [Timer startWithDuration: 60 target: nil selector: nil];
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    
                    [timer resume];
                    
                    expectTruth(remainingTime.wasResumeCalled);
                }),
//             it(@"does not pause if already paused",
//                ^{
//                    FAIL(@"write test for pausing when paused");
//                }),
//             it(@"does not resume if already running",
//                ^{
//                    FAIL(@"write test for resuming when ticking");
//                }),
            nil);
}