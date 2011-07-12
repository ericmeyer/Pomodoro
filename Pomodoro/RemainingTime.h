#import <Foundation/Foundation.h>
#import "RemainingTimeProtocol.h"

@interface RemainingTime : NSObject<RemainingTimeProtocol> {
    NSNumber* duration;
    NSDate* startingTime;
}
@property (nonatomic, retain) NSDate* startingTime;

+(NSString*) stringFormatForDuration:(int) duration;
+(id) startWithDuration: (int) duration target: (id) target selector: (id) selector;

-(id) initWithDuration: (int) givenDuration;


@end
