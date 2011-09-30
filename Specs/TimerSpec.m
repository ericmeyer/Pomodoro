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
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: nil on: target];
                    
                    [expect(timer.target) toBeEqualTo: target];
                }),
             it(@"has a selector",
                ^{
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(someSelector) on: nil];
                    expectFalse(timer.selector == nil);
                }),
             it(@"has a valid countdown",
                ^{
                    Timer* timer = [Timer startWithDuration: 10 andCallWhenEnded: @selector(someSelector) on: nil];
                    expectTruth([timer.countdown isValid]);
                }),
             it(@"informs the target that the remaining time did change with the duration",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    [Timer startWithDuration: 123 andCallWhenEnded: @selector(someSelector) on: delegate];
                    
                    expectTruth(delegate.remainingTimeDidChangeWasCalled);
                    [expect(delegate.remainingTimeDidChangeCalledWith) toBeEqualTo: [NSNumber numberWithInt: 123]];
                }),
             it(@"notifies the delegate that time time changes the first check", 
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(someSel) on: delegate];
                    
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 2]];
                }),
             it(@"passes in the remaining seconds when notifying of time change",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(someSel) on: delegate];
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 60;

                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeCalledWith) toBeEqualTo: [NSNumber numberWithInt: 60]];
                }),
             it(@"notifies the delegate a second time if the time changes",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(someSel) on: delegate];
                    
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 60;
                    
                    [timer checkRemainingTime];
                    remainingTime.totalSecondsRemaining = 59;
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 3]];
                }),
             it(@"does not notify the delegate a second time if the time has not changed",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(someSel) on: delegate];
                    
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 60;
                    
                    [timer checkRemainingTime];
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 2]];
                }),
             it(@"performs the given selector if the time ends",
                ^{
                    MockTimerDelegate* delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(timerEnded) on: delegate];
                    
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    remainingTime.totalSecondsRemaining = 0;

                    [timer checkRemainingTime];
                    
                    expectTruth(delegate.timerEndedCalled);
                }),
             it(@"invalidates the countdown on cancel",
                ^{
                    Timer* timer = [Timer startWithDuration: 10 andCallWhenEnded: @selector(someSelector) on: nil];
                    [timer cancel];
                    expectFalse([timer.countdown isValid]);
                }),
             it(@"pauses the timer",
                ^{
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: nil on: nil];
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    
                    [timer pause];
                    
                    expectTruth(remainingTime.wasPauseCalled);
                }),
             it(@"resumes the timer",
                ^{
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: nil on: nil];
                    MockRemainingTime* remainingTime = [[[MockRemainingTime alloc] init] autorelease];
                    timer.remainingTime = remainingTime;
                    
                    [timer resume];
                    
                    expectTruth(remainingTime.wasResumeCalled);
                }),
            nil);
}