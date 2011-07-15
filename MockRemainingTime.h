#import <Foundation/Foundation.h>
#import "RemainingTimeProtocol.h"

@interface MockRemainingTime : NSObject<RemainingTimeProtocol> {
    int totalSecondsRemaining;
    BOOL wasPauseCalled;
    BOOL wasResumeCalled;
}
@property (nonatomic) int totalSecondsRemaining;
@property (nonatomic) BOOL wasPauseCalled;
@property (nonatomic) BOOL wasResumeCalled;

@end
