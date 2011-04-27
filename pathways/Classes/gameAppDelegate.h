//
//  gameAppDelegate.h
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class startScreenViewController;
@class LevelViewController;
@class scoreViewController;
@class highScoreViewController;
@class scoreObject;

typedef enum
{
	MAINSCREEN,
	CHOOSELEVEL,
	LEVEL,
	PLAYERSCORES,
	HIGHSCORES
	
}DelegateGameState;

@interface gameAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
	startScreenViewController *startViewController;
	LevelViewController *aLevelViewController;
	scoreViewController *aScoreViewController;
	highScoreViewController *aHighScoreViewController;
	NSString *levelData;
	scoreObject *currentScore;
	DelegateGameState gameState;
}

@property DelegateGameState gameState;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController * navigationController;
@property (nonatomic, retain) startScreenViewController *startViewController;
@property (nonatomic, retain) LevelViewController *aLevelViewController;
@property (nonatomic, retain) scoreViewController *aScoreViewController;
@property (nonatomic, retain) highScoreViewController *aHighScoreViewController;
@property (nonatomic, retain) NSString *levelData;
@property (nonatomic, retain) scoreObject *currentScore;


- (void) showMainScreen;
- (void) switchLevel;
- (void) showPlayerScores;
- (void) showHighScores;


@end
