#import <Foundation/Foundation.h>
#import "RemainingTimeProtocol.h"
#import "TimerDelegate.h"

@interface Timer : NSObject {
    NSObject<RemainingTimeProtocol>* remainingTime;
    NSObject<TimerDelegate>* target;
    SEL selector;
    int lastRemainingTime;
    
    NSTimer* countdown;
}
@property (nonatomic, retain) NSObject<RemainingTimeProtocol>* remainingTime;
@property (nonatomic, retain) NSObject<TimerDelegate>* target;
@property (nonatomic) SEL selector;
@property (nonatomic) int lastRemainingTime;
@property (nonatomic, retain) NSTimer* countdown;
@property (readonly) NSNumber* duration;

+(id) startWithDuration: (int) duration target: (NSObject<TimerDelegate>*) target selector: (SEL) selector;
-(void) checkRemainingTime;

@end
