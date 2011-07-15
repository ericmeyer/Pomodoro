#import <Foundation/Foundation.h>

@protocol TimerDelegate <NSObject>

-(void) remainingTimeDidChange: (NSNumber*) remainingSeconds;

@end
