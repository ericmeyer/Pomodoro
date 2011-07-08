#import <UIKit/UIKit.h>
#import "PomodoroProtocol.h"

@interface PomodoroViewController : UIViewController {
    UILabel* timerLabel;
    NSTimer* timer;
    NSObject<PomodoroProtocol>* pomo;
}
@property (nonatomic, retain) IBOutlet UILabel* timerLabel;
@property (nonatomic, retain) NSTimer* timer;
@property (nonatomic, retain) NSObject<PomodoroProtocol>* pomo;

-(IBAction) startTimer;
-(void) refreshTimerLabel;

@end
