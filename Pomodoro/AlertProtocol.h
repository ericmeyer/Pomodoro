#import <Foundation/Foundation.h>

@protocol AlertProtocol <NSObject>

-(void) trigger;
-(void) triggerSound;
-(void) triggerDialog;

@end
