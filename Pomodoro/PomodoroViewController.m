#import "PomodoroViewController.h"
#import "Pomodoro.h"

@implementation PomodoroViewController

@synthesize timer;

-(void)dealloc {
    [super dealloc];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewDidLoad
{
    [super viewDidLoad];
    Pomodoro* pomo = [[Pomodoro alloc] init];
    self.timer.text = [NSString stringWithFormat: @"%@:00", pomo.duration];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
