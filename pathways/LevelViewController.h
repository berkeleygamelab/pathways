//
//  LevelViewController.h
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "draggable.h"
#import "sideButton.h"
#import "mapBoard.h"
#import "pieceBoard.h"
#import "scoreViewController.h"

typedef enum
{
	NONEACTIVE,
	LEFTACTIVE,
	RIGHTACTIVE,
	COMPLETE
	
}Level1Gamestate;

@interface LevelViewController : UIViewController {
	//boards
	mapBoard *leftMapBoard;
	mapBoard *rightMapBoard;
	pieceBoard *leftPieceBoard;
	pieceBoard *rightPieceBoard;
	
	//pieces
	NSMutableArray *leftPieces;
	NSMutableArray *rightPieces;
	int numBlocks;
	int numBlocksLeft;
	int numBlocksRight;
	
	//images and labels
	IBOutlet UILabel *scoreLabel;
	IBOutlet UILabel *timerLabel;
	UIImageView *overlayImage;
	IBOutlet UILabel *pausedLabel;
	IBOutlet UILabel *pressButtonsLabel;
	IBOutlet UILabel *blurbLabel;
	IBOutlet UIImageView *leftArrow;
	IBOutlet UIImageView *rightArrow;
	IBOutlet UILabel *leftSideCompletedLabel;
	IBOutlet UILabel *rightSideCompletedLabel;
	
	//timer
	NSTimer *timer;
	int leftTime;
	int rightTime;
	BOOL timerValid;
	
	//buttons
	IBOutlet UIButton *leftButton;
	IBOutlet UIButton *rightButton;
	
	//alerts
	UIAlertView *quitAlert;
	UIAlertView *infoAlert;
	
	//score handling
	scoreViewController *aScoreViewController;
	int leftScore;
	int rightScore;
	int score;
	NSMutableArray *scoreArray;

	//nextLevel 
	LevelViewController *nextLevelViewController;
	
	Level1Gamestate gamestate;
	
}

@property Level1Gamestate gamestate;
@property (nonatomic, retain) mapBoard *leftMapBoard;
@property (nonatomic, retain) mapBoard *rightMapBoard;
@property (nonatomic, retain) NSMutableArray *leftPieces;
@property (nonatomic, retain) NSMutableArray *rightPieces;
@property (nonatomic, retain) pieceBoard *leftPieceBoard;
@property (nonatomic, retain) pieceBoard *rightPieceBoard;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) IBOutlet UIButton *leftButton;
@property (nonatomic, retain) IBOutlet UIButton *rightButton;
@property (nonatomic, retain) UIImageView *overlayImage;
@property (nonatomic, retain) IBOutlet UILabel *pausedLabel;
@property (nonatomic, retain) IBOutlet UILabel *pressButtonsLabel;
@property (nonatomic, retain) IBOutlet UILabel *blurbLabel;
@property (nonatomic, retain) IBOutlet UIImageView *leftArrow;
@property (nonatomic, retain) IBOutlet UIImageView *rightArrow;
@property (nonatomic, retain) UIAlertView *quitAlert;
@property (nonatomic, retain) UIAlertView *infoAlert;
@property (nonatomic, retain) scoreViewController *aScoreViewController;
@property (nonatomic, retain) LevelViewController *nextLevelViewController;

@property (nonatomic, retain) IBOutlet UILabel *leftSideCompletedLabel;
@property (nonatomic, retain) IBOutlet UILabel *rightSideCompletedLabel;


-(IBAction)backButtonPressed:(UIButton *)backButton;
-(IBAction)infoButtonPressed:(UIButton *)infoButton;
-(IBAction)leftSideTouchDown:(UIButton *)leftButton;
-(IBAction)leftSideTouchUp:(UIButton *)leftButton;
-(IBAction)rightSideTouchDown:(UIButton *)rightButton;
-(IBAction)rightSideTouchUp:(UIButton *)rightButton;
-(void)piecePlacedAction:(draggable *)piece;
-(void)pieceMisplacedAction:(draggable *)piece;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLevelData:(NSString *)levelData 
		withLeftScore:(int)oldLeftScore withRightScore:(int)oldRightScore withScore:(int)oldTotalScore;

-(void)showOverlay;
-(void)hideOverlay;


@end
