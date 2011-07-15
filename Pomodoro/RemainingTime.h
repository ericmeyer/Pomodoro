#import <Foundation/Foundation.h>
#import "RemainingTimeProtocol.h"

@interface RemainingTime : NSObject<RemainingTimeProtocol> {
    NSNumber* duration;
    NSDate* startingTime;
    NSDate* pauseTime;
    NSDate* resumeTime;
    NSTimeInterval elapsedPauseTime;
}
@property (nonatomic, retain) NSDate* startingTime;
@property (nonatomic, retain) NSDate* pauseTime;
@property (nonatomic, retain) NSDate* resumeTime;
@property (nonatomic) NSTimeInterval elapsedPauseTime;

+(NSString*) stringFormatForDuration:(int) duration;

-(id) initWithDuration: (int) givenDuration;

@end
