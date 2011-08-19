#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "Timer.h"

#import <QuartzCore/QuartzCore.h>

@interface PomodoroViewController ()

-(void) changeButtonTargetTo: (SEL) selector withText:(NSString*)text;

@end

@implementation PomodoroViewController

@synthesize timerLabel, timer, button;

-(void) dealloc {
    [super dealloc];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
-(void) viewDidLoad {
    [super viewDidLoad];
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self.button.titleLabel setFont: [UIFont fontWithName: @"Comfortaa-Bold" size: 19.56]];
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
//    UIImage* image = [UIImage imageNamed: @"cancel_button.png"];
//    CGRect newFrame = self.button.frame;
//    newFrame.size = CGSizeMake(200, 50.0);
//    self.button.frame = newFrame;
//    [self.button setImage: image forState: UIControlStateNormal];
}

-(IBAction) cancelPomodoro {
    [timer cancel];
    [self changeButtonTargetTo: @selector(startPomodoro) withText:@"go"];
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
    [self changeButtonTargetTo: @selector(startPomodoro) withText:@"go"];
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
