#import <Foundation/Foundation.h>

@protocol RemainingTimeProtocol <NSObject>

@property (nonatomic, retain) NSNumber* duration;

-(NSNumber*) remainingSecondsAt: (NSDate*) givenTime;

@end
