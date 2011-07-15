#import <Foundation/Foundation.h>
#import "RemainingTimeProtocol.h"
#import "TimerDelegate.h"

@interface Timer : NSObject {
    NSObject<RemainingTimeProtocol>* remainingTime;
    NSObject<TimerDelegate>* target;
    SEL selector;
    int lastRemainingTime;
    
    NSTimer* countdown;
    BOOL isPaused;
}
@property (nonatomic, retain) NSObject<RemainingTimeProtocol>* remainingTime;
@property (nonatomic, retain) NSObject<TimerDelegate>* target;
@property (nonatomic) SEL selector;
@property (nonatomic) int lastRemainingTime;
@property (nonatomic, retain) NSTimer* countdown;
@property (readonly) NSNumber* duration;
@property (nonatomic) BOOL isPaused;

+(id) startWithDuration: (int) duration target: (NSObject<TimerDelegate>*) target selector: (SEL) selector;
-(void) checkRemainingTime;
-(void) cancel;
-(void) pause;
-(void) resume;

@end
