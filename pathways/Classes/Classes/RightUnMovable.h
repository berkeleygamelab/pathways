//
//  test2.h
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Seg.h"
#import "point.h"

@interface RightUnMovable : UIView {
	CGPoint startLocation;
	CGContextRef aRef;
	NSMutableArray *segs;
@public
	point *pt;
	double X0,X1,Y0,Y1;
	UIBezierPath * myPath;
	UIColor* color;
}

- (id)initWithFrame:(CGRect)frame1 andSegs:(NSMutableArray *)segments andPt:(point *) pointt andColor:(UIColor *) clr;


@end
