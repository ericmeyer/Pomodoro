#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "Timer.h"

@implementation PomodoroViewController

@synthesize gogo, pomodoro, timerLabel, timer;

-(void) dealloc {
    [super dealloc];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
-(void) viewDidLoad {
    [super viewDidLoad];
    self.gogo.font = [UIFont fontWithName: @"Comfortaa" size: 42.0];
    self.pomodoro.font = [UIFont fontWithName: @"Comfortaa" size: 42.0];
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
}

-(void) viewDidUnload {
    [super viewDidUnload];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) startPomodoro {
   timer = [Timer startWithDuration: POMODORO_DURATION target: self selector: @selector(startSnooze)];
}

-(IBAction) pausePomodoro {
    [timer pause];
}

-(IBAction) resumePomodoro {
    [timer resume];
}

-(void) startSnooze {
    timer = [Timer startWithDuration: SNOOZE_DURATION target: self selector: @selector(startSnooze)];
}

-(void) startBreak {
    timer = [Timer startWithDuration: BREAK_DURATION target: self selector: @selector(breakEnded)];
}

-(void) breakEnded {
    
}

-(void) remainingTimeDidChange:(NSNumber*)remainingSeconds {
    self.timerLabel.text = [RemainingTime stringFormatForDuration: [remainingSeconds intValue]];
}

@end
