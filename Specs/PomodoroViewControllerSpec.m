#import "OCDSpec/OCDSpec.h"
#import "PomodoroViewController.h"
#import "RemainingTime.h"

void loadButtonsFor(PomodoroViewController *controller) 
{
    controller.cancelButton = [[UIButton alloc] init];
    controller.goButton = [[UIButton alloc] init];
    controller.startBreakButton = [[UIButton alloc] init];
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
             it(@"changes the text to start break when starting a snooze",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.goButton = [[UIButton alloc] init];
                    [controller startSnooze];
                    
                    NSString* title = controller.goButton.titleLabel.text;
                    [expect(title) toBeEqualTo: @"start break"];
                }),
             it(@"changes the button's action to startBreak when starting a snooze",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.goButton = [[UIButton alloc] init];
                    [controller startSnooze];
                    
                    NSArray* actions = [controller.goButton actionsForTarget: controller forControlEvent: UIControlEventTouchUpInside];
                    [expect([NSNumber numberWithInt: [actions count]]) toBeEqualTo: [NSNumber numberWithInt: 1]];
                    [expect([actions objectAtIndex: 0]) toBeEqualTo: @"startBreak"];
                }),
             it(@"starts a break",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller startBreak];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: BREAK_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(breakEnded))];
                }),
             it(@"changes the button text to cancel when starting a break",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.goButton = [[UIButton alloc] init];
                    [controller startBreak];
                    
                    NSString* title = controller.goButton.titleLabel.text;
                    [expect(title) toBeEqualTo: @"cancel"];
                }),
             it(@"changes the button to a cancel action when the break starts",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.goButton = [[UIButton alloc] init];
                    
                    [controller startBreak];
                    
                    NSArray* actions = [controller.goButton actionsForTarget: controller forControlEvent: UIControlEventTouchUpInside];
                    [expect([NSNumber numberWithInt: [actions count]]) toBeEqualTo: [NSNumber numberWithInt: 1]];
                    [expect([actions objectAtIndex: 0]) toBeEqualTo: @"cancelPomodoro"];
                }),
             it(@"cancels the old timer before starting the break on start break",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller startSnooze];
                    Timer* oldTimer = controller.timer;

                    [controller startBreak];
                    
                    expectFalse([oldTimer.countdown isValid]);
                }),
             it(@"changes the button text to go when a break ends",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.goButton = [[UIButton alloc] init];
                    [controller breakEnded];
                    
                    NSString* title = controller.goButton.titleLabel.text;
                    [expect(title) toBeEqualTo: @"go"];
                }),
             it(@"changes the button to restart the pomodoro when the break ends",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.goButton = [[UIButton alloc] init];
                    
                    [controller startBreak];
                    [controller breakEnded];
                    
                    NSArray* actions = [controller.goButton actionsForTarget: controller forControlEvent: UIControlEventTouchUpInside];
                    [expect([NSNumber numberWithInt: [actions count]]) toBeEqualTo: [NSNumber numberWithInt: 1]];
                    [expect([actions objectAtIndex: 0]) toBeEqualTo: @"startPomodoro"];
                }),
             nil);
}