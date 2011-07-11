#import <Foundation/Foundation.h>
#import "PomodoroProtocol.h"

@interface MockPomodoro : NSObject<PomodoroProtocol> {
    int minutesRemaining;
    int secondsRemaining;
    NSString* formattedTime;
    BOOL isOver;
}
@property (nonatomic) int minutesRemaining;
@property (nonatomic) int secondsRemaining;
@property (nonatomic,retain) NSString* formattedTime;
@property (nonatomic) BOOL isOver;

@end
