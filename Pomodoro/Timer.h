#import <Foundation/Foundation.h>
#import "TimerProtocol.h"

@interface Timer : NSObject<TimerProtocol> {
    NSNumber* duration;
    NSDate* startingTime;
}
@property (nonatomic, retain) NSNumber* duration;
@property (nonatomic, retain) NSDate* startingTime;

-(id) initWithDuration: (int) givenDuration;
-(int) totalSecondsRemainingAt: (NSDate*) givenTime;

@end
