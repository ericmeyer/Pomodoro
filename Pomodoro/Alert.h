#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AlertProtocol.h"

@interface Alert : NSObject<AlertProtocol> {
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    UIAlertView*    alertDialog;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic, retain) UIAlertView* alertDialog;

@end
