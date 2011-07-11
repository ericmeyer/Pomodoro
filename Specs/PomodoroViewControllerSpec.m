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
                    
                    [expect(controller.timerLabel.text) toBeEqualTo: [controller.pomo stringFormatTimeLeftAt: nil]];
                }),
             it(@"refreshes the label text",
                ^{
                    PomodoroViewController* controller = [[[PomodoroViewController alloc] init] autorelease];
                    controller.timerLabel = [[UILabel alloc] init];
                    MockPomodoro* pomo = [[MockPomodoro alloc] init];
                    pomo.formattedTime = @"23:15";
                    controller.pomo = pomo;
                    
                    [controller refreshTimerLabel];
                    [expect(controller.timerLabel.text) toBeEqualTo: @"23:15"];
                }),
             nil);
}