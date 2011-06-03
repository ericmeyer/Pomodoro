#import <Foundation/Foundation.h>

@interface Pomodoro : NSObject {
    NSNumber* duration;
    NSDate* startingTime;
}
@property (nonatomic, retain) NSNumber* duration;
@property (nonatomic, retain) NSDate* startingTime;

-(void) startAt: (NSDate*) givenTime;
-(NSNumber*) remainingTimeAt: (NSDate*) givenTime;

@end
