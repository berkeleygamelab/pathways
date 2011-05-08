//
//  VoronoiLevelViewController.h
//  Pathways
//
//  Created by Rahul Kartikeya Gupta on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreObject.h"
#import "Voronoi.h"
#import "point.h"
#import "LeftCell.h"
#import "RightCell.h"
#import "scoreViewController.h"
#import "LevelViewController.h"

#include <stdlib.h>

@interface VoronoiLevelViewController : UIViewController {

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
	
	IBOutlet UIButton *leftButton;
	IBOutlet UIButton *rightButton;
	
	//alerts
	UIAlertView *quitAlert;
	UIAlertView *infoAlert;
	
	
	//pieces
	NSMutableArray *leftPieces;
	NSMutableArray *rightPieces;
	int numBlocks;
	int numBlocksLeft;
	int numBlocksRight;
	
	//timer
	NSTimer *timer;
	int leftTime;
	int rightTime;
	BOOL timerValid;
	
	scoreViewController *scores;

	startScreenViewController * startScreen;
	LevelGamestate gamestate;

	
	//Voronoi
	
	Voronoi* v;
	NSArray* pts;
}


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
@property LevelGamestate gamestate;
@property (nonatomic, retain) UIAlertView *quitAlert;
@property (nonatomic, retain) UIAlertView *infoAlert;
@property (nonatomic, retain) scoreObject *playerScore;

@property (nonatomic, retain) IBOutlet UILabel *leftSideCompletedLabel;
@property (nonatomic, retain) IBOutlet UILabel *rightSideCompletedLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withScoreObject:(scoreObject *)theScore;

-(IBAction)backButtonPressed:(UIButton *)backButton;
-(IBAction)infoButtonPressed:(UIButton *)infoButton;
-(IBAction)leftSideTouchDown:(UIButton *)leftButton;
-(IBAction)leftSideTouchUp:(UIButton *)leftButton;
-(IBAction)rightSideTouchDown:(UIButton *)rightButton;
-(IBAction)rightSideTouchUp:(UIButton *)rightButton;


-(void)setupPuzzle;
-(void)showOverlay;
-(void)hideOverlay;
-(void) shiftToCenter;
-(void) leftToCenter;
-(void) rightToCenter;
-(void)countSeconds;
@end
