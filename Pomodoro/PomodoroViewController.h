#import <UIKit/UIKit.h>
#import "TimerProtocol.h"

@interface PomodoroViewController : UIViewController {
    UILabel* timerLabel;
    NSTimer* timer;
    NSObject<TimerProtocol>* pomo;
}
@property (nonatomic, retain) IBOutlet UILabel* timerLabel;
@property (nonatomic, retain) NSTimer* timer;
@property (nonatomic, retain) NSObject<TimerProtocol>* pomo;

-(IBAction) startTimer;
-(void) refreshTimerLabel;

@end
