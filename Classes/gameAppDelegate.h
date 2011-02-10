//
//  gameAppDelegate.h
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "startScreenViewController.h"
#import "LevelViewController.h"
#import "scoreViewController.h"




@interface gameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	startScreenViewController *startViewController;
	LevelViewController *aLevelViewController;
	scoreViewController *aScoreViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) startScreenViewController *startViewController;
@property (nonatomic, retain) LevelViewController *aLevelViewController;
@property (nonatomic, retain) scoreViewController *aScoreViewController;

@end
