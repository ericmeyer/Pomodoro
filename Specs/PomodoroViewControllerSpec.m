#import "OCDSpec/OCDSpec.h"
#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "OCMock.h"
#import "Alert.h"
#import "MockAlert.h"

CONTEXT(PomodoroViewController)
{
    __block PomodoroViewController* controller;
    
    describe(@"PomodoroViewController",
             beforeEach(
                ^{
                    controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];
                    controller.cancelButton = [[UIButton alloc] init];
                    controller.goButton = [[UIButton alloc] init];
                    controller.startBreakButton = [[UIButton alloc] init];
                    controller.cancelBreakButton = [[UIButton alloc] init];
                }),
             it(@"sets the label text on viewDidLoad", 
                ^{
                    [controller viewDidLoad];
                    
                    NSString* formattedDuration = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
                    [expect(controller.timerLabel.text) toBeEqualTo: formattedDuration];
                }),
             it(@"initalizes the alert",
                ^{
                    [controller viewDidLoad];
                    [expect([controller.alert class]) toBeEqualTo: [Alert class]];
                }),
             it(@"updates the label text",
                ^{
                    [controller remainingTimeDidChange: [NSNumber numberWithInt: 145]];
                    [expect(controller.timerLabel.text) toBeEqualTo: @"2:25"];
                }),
             it(@"starts a pomodoro",
                ^{
                    [controller startPomodoro];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: POMODORO_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(pomodoroEnded))];
                }),
             it(@"starts a snooze when the pomodoro ends",
                ^{
                    [controller pomodoroEnded];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: SNOOZE_DURATION]];
                }),
             it(@"shows only the go button on load",
                ^{
                    [controller viewDidLoad];
                    
                    expectFalse(controller.goButton.hidden);
                    expectTruth(controller.cancelButton.hidden);
                    expectTruth(controller.startBreakButton.hidden);
                    expectTruth(controller.cancelBreakButton.hidden);
                }),
             it(@"shows only the cancel button on startPomodoro",
                ^{
                    [controller viewDidLoad];
                    [controller startPomodoro];

                    expectFalse(controller.cancelButton.hidden);
                    expectTruth(controller.goButton.hidden);
                    expectTruth(controller.startBreakButton.hidden);
                    expectTruth(controller.cancelBreakButton.hidden);
                }),
             it(@"shows only the go button when canceling the pomodoro",
                ^{
                    [controller viewDidLoad];
                    [controller startPomodoro];
                    [controller cancelPomodoro];
                    
                    expectFalse(controller.goButton.hidden);
                    expectTruth(controller.cancelButton.hidden);
                    expectTruth(controller.startBreakButton.hidden);
                    expectTruth(controller.cancelBreakButton.hidden);
                }),
             it(@"resets the timer label text on cancel",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];
                    
                    [controller cancelPomodoro];
                    
                    [expect(controller.timerLabel.text) toBeEqualTo: [RemainingTime stringFormatForDuration: POMODORO_DURATION]];
                }),
             it(@"cancels the timer upon pressment of the cancel button",
                ^{
                    [controller viewDidLoad];
                    [controller startPomodoro];
                    [controller cancelPomodoro];
                    
                    expectFalse([controller.timer.countdown isValid]);
                }),
             it(@"starts a snooze",
                ^{
                    [controller viewDidLoad];
                    controller.alert = [[MockAlert alloc] init];
                    [controller startSnooze];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: SNOOZE_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(startSnooze))];
                }),
//             it(@"shows the view on start snooze if it's not visible",
//                ^{
//                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
//                    [controller viewDidLoad];
//                    OCMockObject *alertMock = [OCMockObject partialMockForObject: controller.alert];
//                    
////                    [[[alertMock stub] andReturnValue: NO] isVisible];
//                    [[alertMock expect] show];
//                    
//                    [controller startSnooze];
//                    
//                    [alertMock verify];
//                }),
//             it(@"does not show the view on start snooze if is not visible",
//                ^{
//                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
//                    [controller viewDidLoad];
//                    OCMockObject *alertMock = [OCMockObject partialMockForObject: controller.alert];
//                    
//                    [[[alertMock stub] andReturn: YES] isVisible];
//                    [[alertMock reject] alert];
//                    
//                    [controller startSnooze];
//                    
//                    [alertMock verify];
//                }),
             it(@"shows only the start break button when starting a snooze",
                ^{
                    [controller viewDidLoad];
                    controller.alert = [[MockAlert alloc] init];
                    [controller startPomodoro];
                    [controller startSnooze];
                    
                    expectFalse(controller.startBreakButton.hidden);
                    expectTruth(controller.cancelButton.hidden);
                    expectTruth(controller.goButton.hidden);
                    expectTruth(controller.cancelBreakButton.hidden);
                }),
             it(@"starts a break",
                ^{
                    [controller startBreak];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: BREAK_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(breakEnded))];
                }),
             it(@"shows only the can break button starting a break",
                ^{                    
                    [controller viewDidLoad];
                    [controller startPomodoro];
                    [controller startBreak];
                    
                    expectFalse(controller.cancelBreakButton.hidden);
                    expectTruth(controller.cancelButton.hidden);
                    expectTruth(controller.goButton.hidden);
                    expectTruth(controller.startBreakButton.hidden);
                }),
             it(@"cancels the old timer before starting the break on start break",
                ^{
                    [controller viewDidLoad];
                    controller.alert = [[MockAlert alloc] init];
                    [controller startSnooze];
                    Timer* oldTimer = controller.timer;

                    [controller startBreak];
                    
                    expectFalse([oldTimer.countdown isValid]);
                }),
             nil);
}