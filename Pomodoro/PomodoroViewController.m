#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "Timer.h"

#import <QuartzCore/QuartzCore.h>

@interface PomodoroViewController ()

-(void) changeButtonTargetTo: (SEL) selector withText:(NSString*)text;

@end

@implementation PomodoroViewController

@synthesize timerLabel, timer, goButton, cancelButton, startBreakButton;

-(void) dealloc {
    [super dealloc];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
-(void) viewDidLoad {
    [super viewDidLoad];
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self.goButton.titleLabel setFont: [UIFont fontWithName: @"Comfortaa-Bold" size: 19.56]];
    [self.cancelButton setHidden: YES];
    [self.startBreakButton setHidden: YES];
}

-(void) viewDidUnload {
    [super viewDidUnload];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) startPomodoro {
    timer = [Timer startWithDuration: POMODORO_DURATION target: self selector: @selector(startSnooze)];
    [self.cancelButton setHidden: NO];
    [self.goButton setHidden: YES];
}

-(IBAction) cancelPomodoro {
    [timer cancel];
    timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self.goButton setHidden: NO];
    [self.cancelButton setHidden: YES];
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
    [self changeButtonTargetTo: @selector(startPomodoro) withText:@"go"];
}

-(void) remainingTimeDidChange:(NSNumber*)remainingSeconds {
    self.timerLabel.text = [RemainingTime stringFormatForDuration: [remainingSeconds intValue]];
}

-(void) changeButtonTargetTo: (SEL) selector  withText:(NSString*)text {
    [self.goButton removeTarget: self action: NULL forControlEvents: UIControlEventTouchUpInside];
    [self.goButton addTarget: self action: selector forControlEvents: UIControlEventTouchUpInside];
    [self.goButton setTitle: text forState: UIControlStateNormal];
}

@end
