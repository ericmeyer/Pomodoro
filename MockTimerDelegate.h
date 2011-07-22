#import <Foundation/Foundation.h>
#import "TimerDelegate.h"

@interface MockTimerDelegate : NSObject<TimerDelegate> {
    BOOL remainingTimeDidChangeWasCalled;
    NSNumber* remainingTimeDidChangeCalledWith;
    int count;
    BOOL timerEndedCalled;
}
@property (nonatomic) BOOL remainingTimeDidChangeWasCalled;
@property (nonatomic, retain) NSNumber* remainingTimeDidChangeCalledWith;
@property (nonatomic) int count;
@property (nonatomic, readonly) NSNumber* remainingTimeDidChangeWasCalledTimes;
@property (nonatomic) BOOL timerEndedCalled;

-(void) timerEnded;

@end
