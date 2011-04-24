//
//  highScoreViewController.h
//  Pathways
//
//  Created by Berkeley Game Lab on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameAppDelegate.h"

@interface highScoreViewController : UIViewController {
	NSMutableArray *scoreArray;
	NSMutableArray *topScores;
}

@property (nonatomic, retain) NSMutableArray *scoreArray;
@property (nonatomic, retain) NSMutableArray *topScores;


-(IBAction)doneButtonPressed:(UIButton *)doneButton;

@end
