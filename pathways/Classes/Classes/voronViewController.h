//
//  voronViewController.h
//  voron
//
//  Created by Rahul Kartikeya Gupta on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Voronoi.h"
#import "point.h"
#import "bigTest.h"
#import "LeftCell.h"
#import "RightCell.h"

#include <stdlib.h>


@interface voronViewController : UIViewController {
	RightCell *rpiece1,*rpiece2,*rpiece3,*rpiece4, *rpiece5;
	LeftCell *lpiece1,*lpiece2,*lpiece3,*lpiece4, *lpiece5;
	bigTest* mainT;
	Voronoi* v;
	NSArray* pts;
}

- (IBAction)showLeft:(UIButton *) sender;

- (IBAction)showRight: (UIButton *) sender;

- (IBAction) makeNew: (UIButton *) sender;

@end

