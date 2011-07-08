#import <Foundation/Foundation.h>
#import "PomodoroProtocol.h"

@interface MockPomodoro : NSObject<PomodoroProtocol> {
    int minutesRemaining;
    int secondsRemaining;
    BOOL isOver;
}
@property (nonatomic) int minutesRemaining;
@property (nonatomic) int secondsRemaining;
@property (nonatomic) BOOL isOver;

@end
