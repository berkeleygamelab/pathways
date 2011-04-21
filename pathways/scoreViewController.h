//
//  scoreViewController.h
//  Pathways
//
//  Created by Berkeley Game Lab on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface scoreViewController : UIViewController {
	//IBOutlet UIScrollView *scoreScrollView;
	int totalScore;
	int leftScore;
	int rightScore;
	NSMutableArray *scoreArray;
	
}

@property (nonatomic, retain) IBOutlet UILabel *scoreScrollView;

-(IBAction)doneButtonPressed:(UIButton *)doneButton;

-(void)loadScores;
//-(void)updateScores;
//-(void)saveScores;
-(void)showScores;
-(void) showGraph;


@end
