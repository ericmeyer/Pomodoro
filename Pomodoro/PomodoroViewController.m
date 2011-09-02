#import "PomodoroViewController.h"
#import "RemainingTime.h"
#import "Timer.h"

#import <QuartzCore/QuartzCore.h>
//#import <AudioToolbox/AudioToolbox.h>

@interface PomodoroViewController ()

-(void) show: (UIButton*) buttonToShow;

@end

@implementation PomodoroViewController

@synthesize timerLabel, timer, goButton, cancelButton, startBreakButton, cancelBreakButton, buttons, alert;
//, alert, soundFileURLRef, soundFileObject;

-(void) dealloc {
    [super dealloc];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
-(void) viewDidLoad {
    [super viewDidLoad];
    alert = [[UIAlertView alloc] initWithTitle:@"It's time to start your break" message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self.goButton.titleLabel setFont: [UIFont fontWithName: @"Comfortaa-Bold" size: 19.56]];
    self.buttons = [NSArray arrayWithObjects: self.startBreakButton,
                                              self.cancelButton,
                                              self.cancelBreakButton,
                                              self.goButton,
                                              nil];
    [self show: goButton];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"black_bg.png"]];
}

-(void) viewDidUnload {
    [super viewDidUnload];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) startPomodoro {
    timer = [Timer startWithDuration: POMODORO_DURATION target: self selector: @selector(startSnooze)];
    [self show: cancelButton];
}

-(IBAction) cancelPomodoro {
    [timer cancel];
    timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    [self show: goButton];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"black_bg.png"]];
}

-(void) startSnooze {
    timer = [Timer startWithDuration: SNOOZE_DURATION target: self selector: @selector(startSnooze)];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"start_break_bg.png"]];
//    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap"
//                                                withExtension: @"aif"];
//    
//    // Store the URL as a CFURLRef instance
//    self.soundFileURLRef = (CFURLRef) [tapSound retain];
//    
//    // Create a system sound object representing the sound file.
//    AudioServicesCreateSystemSoundID (
//                                      
//                                      soundFileURLRef,
//                                      &soundFileObject
//                                      );
//    AudioServicesPlayAlertSound (soundFileObject);
//
    if (![alert isVisible]) {
        [alert show];
    }
    [self show: startBreakButton];
}

-(IBAction) startBreak {
    [timer cancel];
    timer = [Timer startWithDuration: BREAK_DURATION target: self selector: @selector(breakEnded)];
    [self show: cancelBreakButton];
}

-(void) breakEnded {
    self.timerLabel.text = [RemainingTime stringFormatForDuration: POMODORO_DURATION];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"black_bg.png"]];
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

@end
