#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "Timer.h"

#import <QuartzCore/QuartzCore.h>

@interface PomodoroViewController ()

-(void) changeButtonTargetTo: (SEL) selector withText:(NSString*)text;

@end

@implementation PomodoroViewController

@synthesize timerLabel, timer, goButton, cancelButton, startBreakButton, cancelBreakButton;

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
    [self.cancelBreakButton setHidden: YES];
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
    [self.cancelBreakButton setHidden: YES];
    [self.startBreakButton setHidden: YES];
}

-(IBAction) cancelPomodoro {
    [timer cancel];
    timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self.goButton setHidden: NO];
    [self.cancelButton setHidden: YES];
    [self.cancelBreakButton setHidden: YES];
    [self.startBreakButton setHidden: YES];
    self.view.backgroundColor = [[UIColor alloc] initWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
}

-(void) startSnooze {
    timer = [Timer startWithDuration: SNOOZE_DURATION target: self selector: @selector(startSnooze)];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"start_break_bg.png"]];
    [self.startBreakButton setHidden: NO];
    [self.cancelButton setHidden: YES];
}

-(IBAction) startBreak {
    [timer cancel];
    timer = [Timer startWithDuration: BREAK_DURATION target: self selector: @selector(breakEnded)];
    [self.cancelBreakButton setHidden: NO];
    [self.cancelButton setHidden: YES];
    [self.startBreakButton setHidden: YES];
    [self.goButton setHidden: YES];
}

-(void) breakEnded {
//    [self changeButtonTargetTo: @selector(startPomodoro) withText:@"go"];
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    self.view.backgroundColor = [[UIColor alloc] initWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    [self.goButton setHidden: NO];
    [self.cancelButton setHidden: YES];
    [self.startBreakButton setHidden: YES];
    [self.cancelBreakButton setHidden: YES];
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
