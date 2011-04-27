//
//  startScreenViewController.h
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelViewController.h"
#import "scoreObject.h"
#import "gameAppDelegate.h"
#import "LevelPickViewController.h"

typedef enum
{
	STARTSCREEN,
	PLAYING
	
}PathwaysGamestate;

@interface startScreenViewController : UIViewController {
	LevelViewController *level1ViewController;
	LevelViewController *level2ViewController;
	LevelPickViewController * levelPick;
	draggable *draggable1;
	draggable *draggable2;
	draggable *draggable3;
	draggable *draggable4;
	draggable *draggable5;
	PathwaysGamestate gamestate;
	scoreViewController *aScoreViewController;
	draggable *player1Draggable;
	IBOutlet UIButton *player1Button;


}

@property (nonatomic, retain) LevelViewController *level1ViewController;
@property (nonatomic, retain) LevelViewController *level2ViewController;

@property (nonatomic, retain) draggable *draggable1;
@property (nonatomic, retain) draggable *draggable2;
@property (nonatomic, retain) draggable *draggable3;
@property (nonatomic, retain) draggable *draggable4;
@property (nonatomic, retain) draggable *draggable5;
@property (nonatomic, retain) draggable *player1Draggable;
@property (nonatomic, retain) scoreViewController *aScoreViewController;
@property PathwaysGamestate gamestate;

@property (nonatomic, retain) IBOutlet UIButton *player1Button;

-(IBAction)scoreButtonPressed:(UIButton *)sender;
-(void)piecePlacedAction:(draggable *)piece;
-(void)pieceMisplacedAction:(draggable *)piece;
//-(void)createDraggable;
-(void) createPlayer1Draggable;
-(void)makeLevel1WithLevelData:(NSString *) levelData withLeftScore:(int)oldLeftScore withRightScore:(int)oldRightScore withScore:(int)oldTotalScore;
-(void)makeLevel2WithLevelData:(NSString *) levelData withLeftScore:(int)oldLeftScore withRightScore:(int)oldRightScore withScore:(int)oldTotalScore;

-(void)makeLevel1WithLevelData:(NSString *)levelData withScoreObject:(scoreObject *)score;

@end
