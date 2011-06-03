#import <UIKit/UIKit.h>
#import "Pomodoro.h"

@interface PomodoroViewController : UIViewController {
    UILabel* timerLabel;
    NSTimer* timer;
    Pomodoro* pomo;
}
@property (nonatomic, retain) IBOutlet UILabel* timerLabel;
@property (nonatomic, retain) NSTimer* timer;
@property (nonatomic, retain) Pomodoro* pomo;

-(IBAction) startTimer;
-(void) refreshTimerLabel;

@end
