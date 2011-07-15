#import "Timer.h"
#import "RemainingTime.h"
#import "TimerDelegate.h"

@implementation Timer

@synthesize remainingTime, target, selector, lastRemainingTime, countdown;

+(id) startWithDuration:(int)duration target:(NSObject<TimerDelegate>*)target selector:(SEL)selector {
    Timer* timer = [[[Timer alloc] init] autorelease];
    timer.remainingTime = [[RemainingTime alloc] initWithDuration: duration];
    timer.target = target;
    timer.selector = selector;
    timer.countdown = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: timer selector: @selector(checkRemainingTime) userInfo: nil repeats: YES];
    return timer;
}
-(void) pause {
    [remainingTime pauseAt: [NSDate date]];
}
-(void) resume {
    [remainingTime resumeAt: [NSDate date]];
}

-(void) checkRemainingTime {
    NSDate* now = [NSDate date];
    int newRemainingTime = [[remainingTime remainingSecondsAt: now] intValue];
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

-(void) cancel {
    [countdown invalidate];
}

-(void) dealloc {
    if ([countdown isValid]) {
        [countdown invalidate];
    }
    [remainingTime release];
    [target release];
    [countdown release];
    [super dealloc];
}

@end
