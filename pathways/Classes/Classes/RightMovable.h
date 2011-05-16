//
//  NonMovable.h
//  voron
//
//  Created by Rahul Kartikeya Gupta on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seg.h"
#import "point.h"

@interface RightMovable : UIView {
	CGPoint startLocation;
	CGContextRef aRef;
	NSMutableArray *segs;
	int num;
	UIColor *color;
	CGRect endFrame,startFrame;
@public
	point *pt;
	double X0,X1,Y0,Y1;
	UIBezierPath * aPath;
	
}

- (id)initWithFrame:(CGRect)frame andSegs:(NSMutableArray *) segments andPt:(point *) pointt andNum:(int)number andFrame:(CGRect) frame2 andColor:(UIColor *) clr;

- (BOOL) doesMatch;
@end
