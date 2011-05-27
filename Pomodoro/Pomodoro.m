#import "Pomodoro.h"

@implementation Pomodoro

@synthesize duration;

-(id) init {
    if ((self == [super init])) {
        self.duration = [NSNumber numberWithInt: 25];
    }
    return self;
}

@end
