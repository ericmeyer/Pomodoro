#import <UIKit/UIKit.h>
#import "TimerDelegate.h"
#import "Timer.h"

#define POMODORO_DURATION 5
#define SNOOZE_DURATION 3
#define BREAK_DURATION 123

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
