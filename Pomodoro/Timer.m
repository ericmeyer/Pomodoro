#import "Timer.h"
#import "RemainingTime.h"
#import "TimerDelegate.h"

@implementation Timer

@synthesize remainingTime, target, selector, lastRemainingTime, countdown;

+(id) startWithDuration:(int)duration target:(NSObject<TimerDelegate>*)target selector:(SEL)selector {
    Timer* timer = [[[Timer alloc] init] autorelease];
    timer.remainingTime = [[RemainingTime alloc] initWithDuration: duration];
    [timer.remainingTime startAt: [NSDate date]];
    timer.target = target;
    timer.selector = selector;
    timer.countdown = [NSTimer scheduledTimerWithTimeInterval: 0.25 target: timer selector: @selector(checkRemainingTime) userInfo: nil repeats: YES];
    return timer;
}

-(void) checkRemainingTime {
    NSDate* now = [NSDate date];
    int newRemainingTime = [remainingTime totalSecondsRemainingAt: now];
    if (newRemainingTime != lastRemainingTime) {
        lastRemainingTime = newRemainingTime;
        [target remainingTimeDidChange: [NSNumber numberWithInt: newRemainingTime]];
    }
    if (newRemainingTime <= 0) {
        [target performSelector: selector];
        [countdown invalidate];
    }
}

-(NSNumber*) duration {
    return self.remainingTime.duration;
}

-(void) dealloc {
    [remainingTime release];
    [target release];
    [countdown release];
    [super dealloc];
}

@end
