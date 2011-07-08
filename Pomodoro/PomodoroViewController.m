#import "PomodoroViewController.h"
#import "Pomodoro.h"

@implementation PomodoroViewController

@synthesize timerLabel, timer, pomo;

-(void) dealloc {
    [super dealloc];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
-(void) viewDidLoad {
    [super viewDidLoad];
    self.pomo = [[Pomodoro alloc] init];
    self.timerLabel.text =  @"25:00";
}

-(void) viewDidUnload {
    [super viewDidUnload];
    [self.pomo release];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) startTimer {
    [self.pomo startAt: [NSDate date]];
    [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(refreshTimerLabel) userInfo: nil repeats: YES];
    [self refreshTimerLabel];
}

-(void) refreshTimerLabel {
    NSDate* now = [NSDate date];
    self.timerLabel.text = [NSString stringWithFormat: @"%d:%02d",
                            [[self.pomo minutesRemainingAt: now] intValue],
                            [[self.pomo secondsRemainingAt: now] intValue]];
}

@end
