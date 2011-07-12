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