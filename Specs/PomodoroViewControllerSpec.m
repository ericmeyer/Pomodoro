#import "OCDSpec/OCDSpec.h"
#import "PomodoroViewController.h"
#import "MockPomodoro.h"

CONTEXT(PomodoroViewController)
{
    describe(@"PomodoroViewController",
             it(@"sets the label text on viewDidLoad", 
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];
                    [controller viewDidLoad];
                    
                    [expect(controller.timerLabel.text) toBeEqualTo: @"25:00"];
                }),
             it(@"refreshes the label text",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];
                    MockPomodoro* pomo = [[MockPomodoro alloc] init];
                    pomo.minutesRemaining = 23;
                    pomo.secondsRemaining = 15;
                    controller.pomo = pomo;
                    
                    [controller refreshTimerLabel];
                    [expect(controller.timerLabel.text) toBeEqualTo: @"23:15"];
                }),
             it(@"refreshes the label text with single digit seconds",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];
                    MockPomodoro* pomo = [[MockPomodoro alloc] init];
                    pomo.minutesRemaining = 6;
                    pomo.secondsRemaining = 3;
                    controller.pomo = pomo;
                    
                    [controller refreshTimerLabel];
                    [expect(controller.timerLabel.text) toBeEqualTo: @"6:03"];
                }),
             nil);
}