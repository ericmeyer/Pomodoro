#import "Alert.h"

@implementation Alert

@synthesize soundFileObject, soundFileURLRef, alertDialog;

-(id) init {
    if ((self = [super init])) {
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap"
                                                    withExtension: @"aif"];
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
    AudioServicesPlayAlertSound (soundFileObject);
    if (![alertDialog isVisible]) {
        [alertDialog show];
    }
}

@end
