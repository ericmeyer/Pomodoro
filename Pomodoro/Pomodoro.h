#import <Foundation/Foundation.h>
#import "PomodoroProtocol.h"

@interface Pomodoro : NSObject<PomodoroProtocol> {
    NSNumber* duration;
    NSDate* startingTime;
}
@property (nonatomic, retain) NSNumber* duration;
@property (nonatomic, retain) NSDate* startingTime;

-(id) initWithDuration: (int) givenDuration;
-(int) totalSecondsRemainingAt: (NSDate*) givenTime;

@end
