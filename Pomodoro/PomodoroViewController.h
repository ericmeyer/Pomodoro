#import <UIKit/UIKit.h>
#import "TimerDelegate.h"
#import "Timer.h"

#define TESTING_TIMING 0

#if TESTING_TIMING
    #define POMODORO_DURATION 8
    #define SNOOZE_DURATION 5
    #define BREAK_DURATION 6
#else
    #define POMODORO_DURATION 25*60
    #define SNOOZE_DURATION 1*60
    #define BREAK_DURATION 5*60
#endif

@interface PomodoroViewController : UIViewController<TimerDelegate> {
    UILabel* timerLabel;
    Timer* timer;
    UIButton* button;
}
@property (nonatomic, retain) IBOutlet UILabel* timerLabel;
@property (nonatomic, retain) Timer* timer;
@property (nonatomic, retain) IBOutlet UIButton* button;

-(IBAction) startPomodoro;
-(IBAction) cancelPomodoro;
-(void) startSnooze;
-(void) startBreak;

-(void) breakEnded;

@end
