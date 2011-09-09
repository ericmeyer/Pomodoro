#import "Alert.h"

@implementation Alert

@synthesize soundFileObject, soundFileURLRef, alertDialog;

-(id) init {
    if ((self = [super init])) {
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"slime_splash"
                                                    withExtension: @"mp3"];
        self.soundFileURLRef = (CFURLRef) [tapSound retain];
        AudioServicesCreateSystemSoundID (
                                          
                                          soundFileURLRef,
                                          &soundFileObject
                                          );
        alertDialog = [[UIAlertView alloc] initWithTitle:@"It's time to start your break" message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
    }
    return self;
}

-(void) trigger {
    [self triggerSound];
    [self triggerDialog];
}

-(void) triggerSound {
    AudioServicesPlayAlertSound (soundFileObject);    
}

-(void) triggerDialog {
    if (![alertDialog isVisible]) {
        [alertDialog show];
    }
}

@end
