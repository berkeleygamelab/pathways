//
//  startScreenViewController.h
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelViewController.h"

typedef enum
{
	STARTSCREEN,
	PLAYING
	
}PathwaysGamestate;

@interface startScreenViewController : UIViewController {
	LevelViewController *level1ViewController;
	LevelViewController *level2ViewController;
	draggable *draggable1;
	PathwaysGamestate gamestate;
	scoreViewController *aScoreViewController;

}

@property (nonatomic, retain) LevelViewController *level1ViewController;
@property (nonatomic, retain) LevelViewController *level2ViewController;

@property (nonatomic, retain) draggable *draggable1;
@property (nonatomic, retain) scoreViewController *aScoreViewController;
@property PathwaysGamestate gamestate;


-(IBAction)scoreButtonPressed:(UIButton *)sender;
-(void)piecePlacedAction:(draggable *)piece;
-(void)pieceMisplacedAction:(draggable *)piece;
-(void)createDraggable;
@end
