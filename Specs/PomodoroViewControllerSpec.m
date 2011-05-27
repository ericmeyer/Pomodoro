#import "OCDSpec/OCDSpec.h"
#import "PomodoroViewController.h"

CONTEXT(PomodoroViewController)
{
    describe(@"PomodoroViewController should exist",
             it(@"Fails", 
                ^{
                    PomodoroViewController* controller = [[PomodoroViewController alloc] init];
                    controller.timer = [[UILabel alloc] init];
                    [controller viewDidLoad];
                    
                    [expect(controller.timer.text) toBeEqualTo: @"25:00"];
                }),
             
             nil);
}