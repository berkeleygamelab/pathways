//
//  scoreViewController.h
//  Pathways
//
//  Created by Berkeley Game Lab on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreObject.h"
#import "ScoreTableCell.h"
#import "gameAppDelegate.h"

@interface scoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	NSMutableArray *scoreArray;
	NSMutableArray *playerScoreArray;
	
	UIImageView *graphImageView;
	IBOutlet UILabel *playerLabel;
	IBOutlet UIButton *graphViewButton;
	NSString *currPlayerName;
	NSMutableString *LHDataString;
	NSMutableString *RHDataString;	
	NSMutableString *TotalDataString;
	IBOutlet UITableView *scoreTableView;
}

//@property (nonatomic, retain) IBOutlet UILabel *scoreScrollView;
@property (nonatomic, retain) IBOutlet UILabel *playerLabel;
@property (nonatomic, retain) IBOutlet UIButton *graphViewButton;
@property (nonatomic, retain) UIImageView *graphImageView;
@property (nonatomic, retain) NSString *currPlayerName;
@property (nonatomic, retain) NSMutableString *LHDataString;
@property (nonatomic, retain) NSMutableString *RHDataString;
@property (nonatomic, retain) NSMutableString *TotalDataString;
@property (nonatomic, retain) IBOutlet UITableView *scoreTableView;

-(IBAction)doneButtonPressed:(UIButton *)doneButton;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCurrentScore:(scoreObject *)currScore;

-(void)loadScores;
//-(void)updateScores;
//-(void)saveScores;
//-(void)showScores;
-(void) showGraph;


@end
