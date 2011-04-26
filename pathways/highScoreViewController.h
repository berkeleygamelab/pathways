//
//  highScoreViewController.h
//  Pathways
//
//  Created by Berkeley Game Lab on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameAppDelegate.h"
#import "ScoreTableCell.h"

@interface highScoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	NSMutableArray *scoreArray;
	NSMutableArray *topScores;
	IBOutlet UITableView *scoreTableView;
}

@property (nonatomic, retain) NSMutableArray *scoreArray;
@property (nonatomic, retain) NSMutableArray *topScores;
@property (nonatomic, retain) IBOutlet UITableView *scoreTableView;

-(IBAction)doneButtonPressed:(UIButton *)doneButton;

@end
