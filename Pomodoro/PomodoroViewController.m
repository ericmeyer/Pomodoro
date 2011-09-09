#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "Timer.h"

#import <QuartzCore/QuartzCore.h>
#import "Alert.h"

@interface PomodoroViewController ()

-(void) show: (UIButton*) buttonToShow;

@end

@implementation PomodoroViewController

@synthesize timerLabel, timer, goButton, cancelButton, startBreakButton, cancelBreakButton, buttons, alert;

-(void) dealloc {
    [timerLabel release];
    [timer release];
    [goButton release];
    [cancelButton release];
    [startBreakButton release];
    [cancelBreakButton release];
    [buttons release];
    [alert release];
    [super dealloc];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
-(void) viewDidLoad {
    [super viewDidLoad];
    alert = [[Alert alloc] init];
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    self.buttons = [NSArray arrayWithObjects: self.startBreakButton,
                                              self.cancelButton,
                                              self.cancelBreakButton,
                                              self.goButton,
                                              nil];
    [self show: goButton];
    [self setBackground: @"black_bg.png"];
}

-(void) viewDidUnload {
    [super viewDidUnload];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) startPomodoro {
    self.timer = [Timer startWithDuration: POMODORO_DURATION target: self selector: @selector(startSnooze)];
    [self show: cancelButton];
}

-(IBAction) cancelPomodoro {
    [timer cancel];
    timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self show: goButton];
    [self setBackground: @"black_bg.png"];
}

-(void) startSnooze {
    self.timer = [Timer startWithDuration: SNOOZE_DURATION target: self selector: @selector(startSnooze)];
    [self setBackground: @"start_break_bg.png"];
    [alert trigger];
    [self show: startBreakButton];
}

-(IBAction) startBreak {
    [timer cancel];
    self.timer = [Timer startWithDuration: BREAK_DURATION target: self selector: @selector(breakEnded)];
    [self show: cancelBreakButton];
}

-(void) breakEnded {
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self setBackground: @"black_bg.png"];
    [self.alert triggerSound];
    [self show: goButton];
}

-(void) remainingTimeDidChange:(NSNumber*)remainingSeconds {
    self.timerLabel.text = [RemainingTime stringFormatForDuration: [remainingSeconds intValue]];
}

-(void) show: (UIButton*) buttonToShow {
    for (UIButton* button in self.buttons) {
        if (button == buttonToShow) {
            [button setHidden: NO];
        } else {
            [button setHidden: YES];
        }
    }
}

-(void) setBackground: (NSString*) name {
    UIImage* image = [UIImage imageNamed: name];
    UIColor* background = [[UIColor alloc] initWithPatternImage: image];
    self.view.backgroundColor = background;
    [background release];
}

@end
