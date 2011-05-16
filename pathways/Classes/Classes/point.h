//
//  point.h
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface point : NSObject {
	@public
		double x;
		double y;
		BOOL used;

}

- (id) initWithPt:(point *)p;

- (id) initWithX:(double)xx andY:(double)yy andUsed:(BOOL)use;

- (double) getX;

- (NSString *) toString;

- (double) getY;

- (void) setX:(double) xx;

- (void) setY:(double) yy;

- (NSComparisonResult) greaterThan:(point *)p;

@end
