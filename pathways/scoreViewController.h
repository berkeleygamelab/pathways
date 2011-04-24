//
//  scoreViewController.h
//  Pathways
//
//  Created by Berkeley Game Lab on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scoreObject.h"
#import "gameAppDelegate.h"

@interface scoreViewController : UIViewController {
	//IBOutlet UIScrollView *scoreScrollView;
	int totalScore;
	int leftScore;
	int rightScore;
	NSMutableArray *scoreArray;
	UIImageView *graphImageView;
	IBOutlet UILabel *playerLabel;
	IBOutlet UIButton *graphViewButton;
	NSString *currPlayerName;
}

@property (nonatomic, retain) IBOutlet UILabel *scoreScrollView;
@property (nonatomic, retain) IBOutlet UILabel *playerLabel;
@property (nonatomic, retain) IBOutlet UIButton *graphViewButton;
@property (nonatomic, retain) UIImageView *graphImageView;
@property (nonatomic, retain) NSString *currPlayerName;

-(IBAction)doneButtonPressed:(UIButton *)doneButton;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCurrentScore:(scoreObject *)currScore;

-(void)loadScores;
//-(void)updateScores;
//-(void)saveScores;
-(void)showScores;
-(void) showGraph;


@end
