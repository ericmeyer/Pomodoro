#import <Foundation/Foundation.h>
#import "PomodoroProtocol.h"

@interface MockPomodoro : NSObject<PomodoroProtocol> {
    int minutesRemaining;
    int secondsRemaining;
}
@property (nonatomic) int minutesRemaining;
@property (nonatomic) int secondsRemaining;

@end
