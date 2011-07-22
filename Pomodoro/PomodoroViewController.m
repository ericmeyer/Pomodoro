#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "Timer.h"

@interface PomodoroViewController ()

-(void) changeButtonTargetTo: (SEL) selector withText:(NSString*)text;

@end

@implementation PomodoroViewController

@synthesize gogo, pomodoro, timerLabel, timer, button;

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
    self.timerLabel.font = [UIFont fontWithName: @"Podkova" size: 112.0];
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
    [self changeButtonTargetTo: @selector(cancelPomodoro) withText:@"cancel"];
}

-(IBAction) cancelPomodoro {
    [timer cancel];
    [self changeButtonTargetTo: @selector(startPomodoro) withText:@"start task"];
    timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
}

-(void) startSnooze {
    timer = [Timer startWithDuration: SNOOZE_DURATION target: self selector: @selector(startSnooze)];
    [self changeButtonTargetTo: @selector(startBreak) withText:@"start break"];
}

-(void) startBreak {
    [timer cancel];
    timer = [Timer startWithDuration: BREAK_DURATION target: self selector: @selector(breakEnded)];
    [self changeButtonTargetTo: @selector(cancelPomodoro) withText:@"cancel"];
}

-(void) breakEnded {
    
}

-(void) remainingTimeDidChange:(NSNumber*)remainingSeconds {
    self.timerLabel.text = [RemainingTime stringFormatForDuration: [remainingSeconds intValue]];
}

-(void) changeButtonTargetTo: (SEL) selector  withText:(NSString*)text {
    [self.button removeTarget: self action: NULL forControlEvents: UIControlEventTouchUpInside];
    [self.button addTarget: self action: selector forControlEvents: UIControlEventTouchUpInside];
    [self.button setTitle: text forState: UIControlStateNormal];
}

@end
