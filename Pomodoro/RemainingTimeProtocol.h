#import <Foundation/Foundation.h>

@protocol RemainingTimeProtocol <NSObject>

@property (nonatomic, retain) NSNumber* duration;

-(int) remainingSecondsAt: (NSDate*) givenTime;

@end
