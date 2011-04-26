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

typedef enum
{
	STARTSCREEN,
	PLAYING
	
}PathwaysGamestate;

@interface startScreenViewController : UIViewController {
	draggable *draggable1;
	draggable *draggable2;
	draggable *draggable3;
	draggable *draggable4;
	draggable *draggable5;
	PathwaysGamestate gamestate;
}

@property (nonatomic, retain) draggable *draggable1;
@property (nonatomic, retain) draggable *draggable2;
@property (nonatomic, retain) draggable *draggable3;
@property (nonatomic, retain) draggable *draggable4;
@property (nonatomic, retain) draggable *draggable5;
@property PathwaysGamestate gamestate;


-(IBAction)scoreButtonPressed:(UIButton *)sender;
-(void)piecePlacedAction:(draggable *)piece;
-(void)pieceMisplacedAction:(draggable *)piece;
-(void) createPlayer1Draggable;
-(void) createPlayer2Draggable;
-(void) createPlayer3Draggable;
-(void) createPlayer4Draggable;
-(void) createPlayer5Draggable;

@end
