#import "Timer.h"
#import "RemainingTime.h"
#import "TimerDelegate.h"

@implementation Timer

@synthesize remainingTime, target, selector, lastRemainingTime, countdown, isPaused;

+(id) startWithDuration:(int)duration andCallWhenEnded:(SEL)selector on:(NSObject<TimerDelegate>*)target {
    Timer* timer = [[[Timer alloc] init] autorelease];
    RemainingTime* remainingTime = [[RemainingTime alloc] initWithDuration: duration];
    timer.remainingTime = remainingTime;
    [remainingTime release];
    timer.target = target;
    timer.selector = selector;
    [target remainingTimeDidChange: [NSNumber numberWithInt: duration]];
    timer.countdown = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: timer selector: @selector(checkRemainingTime) userInfo: nil repeats: YES];
    return timer;
}
-(void) pause {
    [remainingTime pauseAt: [NSDate date]];
    isPaused = YES;
}
-(void) resume {
    [remainingTime resumeAt: [NSDate date]];
    isPaused = NO;
}

-(void) cancel {
    [countdown invalidate];
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
