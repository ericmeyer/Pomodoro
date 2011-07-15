#import <Foundation/Foundation.h>

@protocol RemainingTimeProtocol <NSObject>

@property (nonatomic, retain) NSNumber* duration;

-(void) pauseAt: (NSDate*) givenTime;
-(void) resumeAt: (NSDate*) givenTime;

-(NSNumber*) remainingSecondsAt: (NSDate*) givenTime;

@end
