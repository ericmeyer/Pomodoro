#import "OCDSpec/OCDSpec.h"
#import "PomodoroViewController.h"
#import "RemainingTime.h"

void loadButtonsFor(PomodoroViewController *controller) 
{
    controller.cancelButton = [[UIButton alloc] init];
    controller.goButton = [[UIButton alloc] init];
    controller.startBreakButton = [[UIButton alloc] init];
    controller.cancelBreakButton = [[UIButton alloc] init];
}

CONTEXT(PomodoroViewController)
{
    describe(@"PomodoroViewController",
             it(@"sets the label text on viewDidLoad", 
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];
                    [controller viewDidLoad];
                    
                    NSString* formattedDuration = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
                    [expect(controller.timerLabel.text) toBeEqualTo: formattedDuration];
                }),
             it(@"updates the label text",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];

                    [controller remainingTimeDidChange: [NSNumber numberWithInt: 145]];
                    [expect(controller.timerLabel.text) toBeEqualTo: @"2:25"];
                }),
             it(@"starts a pomodoro",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller startPomodoro];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: POMODORO_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(startSnooze))];
                }),
             it(@"shows only the go button on load",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    loadButtonsFor(controller);
                    [controller viewDidLoad];
                    
                    expectFalse(controller.goButton.hidden);
                    expectTruth(controller.cancelButton.hidden);
                    expectTruth(controller.startBreakButton.hidden);
                    expectTruth(controller.cancelBreakButton.hidden);
                }),
             it(@"shows only the cancel button on startPomodoro",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    loadButtonsFor(controller);
                    
                    [controller viewDidLoad];
                    [controller startPomodoro];

                    expectFalse(controller.cancelButton.hidden);
                    expectTruth(controller.goButton.hidden);
                    expectTruth(controller.startBreakButton.hidden);
                    expectTruth(controller.cancelBreakButton.hidden);
                }),
             it(@"shows only the go button when canceling the pomodoro",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    loadButtonsFor(controller);
                    
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
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    
                    [controller viewDidLoad];
                    [controller startPomodoro];
                    [controller cancelPomodoro];
                    
                    expectFalse([controller.timer.countdown isValid]);
                }),
             it(@"starts a snooze",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller startSnooze];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: SNOOZE_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(startSnooze))];
                }),
             it(@"shows only the start break button when starting a snooze",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    loadButtonsFor(controller);
                    
                    [controller viewDidLoad];
                    [controller startPomodoro];
                    [controller startSnooze];
                    
                    expectFalse(controller.startBreakButton.hidden);
                    expectTruth(controller.cancelButton.hidden);
                    expectTruth(controller.goButton.hidden);
                    expectTruth(controller.cancelBreakButton.hidden);
                }),
             it(@"starts a break",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller startBreak];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: BREAK_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(breakEnded))];
                }),
             it(@"shows only the can break button starting a break",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    loadButtonsFor(controller);
                    
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
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller startSnooze];
                    Timer* oldTimer = controller.timer;

                    [controller startBreak];
                    
                    expectFalse([oldTimer.countdown isValid]);
                }),
             nil);
}