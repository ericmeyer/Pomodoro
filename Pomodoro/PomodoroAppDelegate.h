//
//  PomodoroAppDelegate.h
//  Pomodoro
//
//  Created by Eric Meyer on 5/27/11.
//  Copyright 2011 8th Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PomodoroViewController;

@interface PomodoroAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PomodoroViewController *viewController;

@end
