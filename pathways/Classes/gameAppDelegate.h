//
//  gameAppDelegate.h
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class	startScreenViewController;
@class LevelViewController;
@class scoreViewController;
@class scoreObject;



@interface gameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	startScreenViewController *startViewController;
	LevelViewController *aLevelViewController;
	scoreViewController *aScoreViewController;
	
	NSString *levelData;
	scoreObject *currentScore;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) startScreenViewController *startViewController;
@property (nonatomic, retain) LevelViewController *aLevelViewController;
@property (nonatomic, retain) scoreViewController *aScoreViewController;

@property (nonatomic, retain) NSString *levelData;
@property (nonatomic, retain) scoreObject *currentScore;


- (void) showMainScreen;
- (void) switchLevel;

@end
