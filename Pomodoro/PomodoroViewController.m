#import "PomodoroViewController.h"

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
    self.timerLabel.text = [NSString stringWithFormat: @"%d", [[self.pomo remainingTimeAt: [NSDate date]] intValue]];
}

@end
