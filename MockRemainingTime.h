#import <Foundation/Foundation.h>
#import "RemainingTimeProtocol.h"

@interface MockRemainingTime : NSObject<RemainingTimeProtocol> {
    int totalSecondsRemaining;
}
@property (nonatomic) int totalSecondsRemaining;

@end
