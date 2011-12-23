#import "OCDSpec/OCDSpec.h"
#import "Timer.h"
#import "MockTimerDelegate.h"
#import "MockRemainingTime.h"

CONTEXT(Timer)
{
    __block MockTimerDelegate* delegate;
    __block Timer* timer;
    __block MockRemainingTime* mockRemainingTime;

    describe(@"Timer",
             beforeEach(
                ^{
                    delegate = [[[MockTimerDelegate alloc] init] autorelease];
                    timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(someSelector) on: delegate];
                    
                    mockRemainingTime = [[[MockRemainingTime alloc] init] autorelease];
                }),
             it(@"has a target when started",
                ^{
                    [expect(timer.target) toBeEqualTo: delegate];
                }),
             it(@"has a selector",
                ^{
                    NSString* timerSelector = NSStringFromSelector(timer.selector);
                    [expect(timerSelector) toBeEqualTo: @"someSelector"];
                }),
             it(@"has a valid countdown",
                ^{
                    expectTruth([timer.countdown isValid]);
                }),
             it(@"informs the target that the remaining time did change with the duration",
                ^{
                    [Timer startWithDuration: 123 andCallWhenEnded: @selector(someSelector) on: delegate];
                    
                    expectTruth(delegate.remainingTimeDidChangeWasCalled);
                    [expect(delegate.remainingTimeDidChangeCalledWith) toBeEqualTo: [NSNumber numberWithInt: 123]];
                }),
             it(@"notifies the delegate on start",
                ^{
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 1]];
                }),
             it(@"notifies the delegate that time time changes the first check", 
                ^{
                    [delegate init];
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 1]];
                }),
             it(@"passes in the remaining seconds when notifying of time change",
                ^{
                    timer.remainingTime = mockRemainingTime;
                    mockRemainingTime.totalSecondsRemaining = 60;

                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeCalledWith) toBeEqualTo: [NSNumber numberWithInt: 60]];
                }),
             it(@"notifies the delegate a second time if the time changes",
                ^{                    
                    [delegate init];
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
                    [delegate init];
                    timer.remainingTime = mockRemainingTime;
                    mockRemainingTime.totalSecondsRemaining = 60;
                    
                    [timer checkRemainingTime];
                    [timer checkRemainingTime];
                    
                    [expect(delegate.remainingTimeDidChangeWasCalledTimes) toBeEqualTo: [NSNumber numberWithInt: 1]];
                }),
             it(@"performs the given selector if the time ends",
                ^{
                    Timer* timer = [Timer startWithDuration: 60 andCallWhenEnded: @selector(timerEnded) on: delegate];
                    
                    timer.remainingTime = mockRemainingTime;
                    mockRemainingTime.totalSecondsRemaining = 0;

                    [timer checkRemainingTime];
                    
                    expectTruth(delegate.timerEndedCalled);
                }),
             it(@"invalidates the countdown on cancel",
                ^{
                    [timer cancel];
                    expectFalse([timer.countdown isValid]);
                }),
             it(@"pauses the remaining time",
                ^{
                    timer.remainingTime = mockRemainingTime;
                    
                    [timer pause];
                    
                    expectTruth(mockRemainingTime.wasPauseCalled);
                }),
             it(@"resumes the remaining time",
                ^{
                    timer.remainingTime = mockRemainingTime;
                    
                    [timer resume];
                    
                    expectTruth(mockRemainingTime.wasResumeCalled);
                }),
            nil);
}