
//  Created by Rahul Kartikeya Gupta on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Seg.h"
#import "point.h"

@interface bigTest: UIView {
	CGPoint startLocation;
	CGContextRef aRef;
	NSMutableArray *segs;
	NSArray *pts;
	double X0,X1,Y0,Y1;
}

- (id)initWithFrame:(CGRect)frame andSegs:(NSMutableArray *)segments andPts:(NSArray *) points;


@end
