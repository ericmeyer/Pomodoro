#import <UIKit/UIKit.h>
#import "TimerDelegate.h"
#import "Timer.h"
#import "AlertProtocol.h"

#define TESTING_TIMING 0


#if TESTING_TIMING
    #define POMODORO_DURATION 5
    #define SNOOZE_DURATION 15
    #define BREAK_DURATION 5
#else
    #define POMODORO_DURATION 25*60
    #define SNOOZE_DURATION 1*60
    #define BREAK_DURATION 5*60
#endif

@interface PomodoroViewController : UIViewController<TimerDelegate> {
    UILabel* timerLabel;
    Timer* timer;
    UIButton* goButton;
    UIButton* cancelButton;
    UIButton* startBreakButton;
    UIButton* cancelBreakButton;
    NSObject<AlertProtocol>* alert;
    NSArray* buttons;
}
@property (nonatomic, retain) IBOutlet UILabel* timerLabel;
@property (nonatomic, retain) Timer* timer;
@property (nonatomic, retain) IBOutlet UIButton* goButton;
@property (nonatomic, retain) IBOutlet UIButton* cancelButton;
@property (nonatomic, retain) IBOutlet UIButton* startBreakButton;
@property (nonatomic, retain) IBOutlet UIButton* cancelBreakButton;
@property (nonatomic, retain) NSArray* buttons;

@property (nonatomic, retain) NSObject<AlertProtocol>* alert;

-(IBAction) startPomodoro;
-(void) pomodoroEnded;
-(IBAction) cancelPomodoro;
-(void) startSnooze;
-(IBAction) startBreak;
-(void) breakEnded;

-(void) setBackground: (NSString*) name;

@end
