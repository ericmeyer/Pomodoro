#import <Foundation/Foundation.h>

@protocol RemainingTimeProtocol <NSObject>

@property (nonatomic, retain) NSNumber* duration;

-(void) startAt: (NSDate*) givenTime;

-(int) totalSecondsRemainingAt: (NSDate*) givenTime;

-(BOOL) isOverAt:(NSDate*) givenTime;

@end
