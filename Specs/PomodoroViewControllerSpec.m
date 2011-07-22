#import "OCDSpec/OCDSpec.h"
#import "PomodoroViewController.h"
#import "RemainingTime.h"

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
             it(@"changes the button to cancel the pomodoro",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.button = [[UIButton alloc] init];
                    [controller.button addTarget: controller action: @selector(startPomodoro) forControlEvents: UIControlEventTouchUpInside];
                    
                    [controller startPomodoro];
                    
                    NSArray* actions = [controller.button actionsForTarget: controller forControlEvent: UIControlEventTouchUpInside];
                    [expect([NSNumber numberWithInt: [actions count]]) toBeEqualTo: [NSNumber numberWithInt: 1]];
                    [expect([actions objectAtIndex: 0]) toBeEqualTo: @"cancelPomodoro"];
                }),
             it(@"changes the button to UNCANCEL the pomodoro",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.button = [[UIButton alloc] init];
                    
                    [controller startPomodoro];
                    [controller cancelPomodoro];
                    
                    NSArray* actions = [controller.button actionsForTarget: controller forControlEvent: UIControlEventTouchUpInside];
                    [expect([NSNumber numberWithInt: [actions count]]) toBeEqualTo: [NSNumber numberWithInt: 1]];
                    [expect([actions objectAtIndex: 0]) toBeEqualTo: @"startPomodoro"];
                }),
             it(@"changes the button text to cancel when starting a pomodoro",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.button = [[UIButton alloc] init];
                    
                    [controller startPomodoro];
                    NSString* title = controller.button.titleLabel.text;
                    [expect(title) toBeEqualTo: @"cancel"];
                }),
             it(@"changes the button text to start task when cancelling a pomodoro",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.button = [[UIButton alloc] init];
                    
                    [controller startPomodoro];
                    [controller cancelPomodoro];
                    
                    NSString* title = controller.button.titleLabel.text;
                    [expect(title) toBeEqualTo: @"start task"];
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
             it(@"starts a break",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller startBreak];
                    
                    [expect(controller.timer.duration) toBeEqualTo: [NSNumber numberWithInt: BREAK_DURATION]];
                    [expect(controller.timer.target) toBeEqualTo: controller];
                    [expect(NSStringFromSelector(controller.timer.selector)) toBeEqualTo: NSStringFromSelector(@selector(breakEnded))];
                }),
             it(@"responds to breakEnded",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    [controller breakEnded];
                }),
             nil);
}