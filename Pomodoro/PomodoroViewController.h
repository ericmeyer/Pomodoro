#import <UIKit/UIKit.h>
#import "TimerDelegate.h"
#import "Timer.h"

#define POMODORO_DURATION 25*60
#define SNOOZE_DURATION 1*60
#define BREAK_DURATION 5*60

@interface PomodoroViewController : UIViewController<TimerDelegate> {
    UILabel* timerLabel;
    Timer* timer;
}
@property (nonatomic, retain) IBOutlet UILabel* timerLabel;
@property (nonatomic, retain) Timer* timer;

-(IBAction) startPomodoro;
-(void) startSnooze;
-(void) startBreak;

-(void) breakEnded;

@end
