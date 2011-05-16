//
//  point.m
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "point.h"


@implementation point


-(id) init 
{
	self = [super init];
	if (self)
	{
		x = 0.0;
		y = 0.0;
	}
	return self;
	
}

-(id) initWithX: (double) xx andY: (double) yy andUsed:(BOOL) use
{
	self = [super init];
	if (self)
	{
		used = use;
		x = xx;
		y = yy;
	}
	return self;
}

-(id) initWithPt:(point *) p {
	self = [super init];
	if (self)
	{
		x = p->x;
		y = p->y;
	}
	return self;
}


-(double) getX
{
	return x;
	
}

-(double) getY
{
	return y;
}

- (void) setX:(double) xx
{
	x = xx;
}

- (void) setY:(double) yy
{
	y = yy;
}


- (NSString *) toString
{
	NSString *s = [[NSString alloc] initWithFormat:@"%f, %f",x,y];
	return s;
	
}
-(NSComparisonResult) greaterThan:(point *)p
{
	if (x == p->x)
	{
		if (y > p->y)
			return NSOrderedDescending;
		else
			return NSOrderedAscending;
	} else {
		if(x > p->x)
			return NSOrderedDescending;
		else if (x < p->x){
			return NSOrderedAscending;
		}
		else {
			return NSOrderedSame;
		}
	}

	
}

@end
