//
//  event.m
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "event.h"


@implementation event


-(id) initWithX:(int)xx andP:(point *)pp andA:(arc *) aa
{
	self = [super init];
	if (self) {
		x = xx;
		p = [[point alloc] initWithPt:pp];
		a = aa;
		valid = YES;
	}
	return self;
}

-(NSComparisonResult) greaterThan: (event *) e
{
	if (x > e->x){
		return NSOrderedDescending;
	}
	else if (x < e->x){
		return NSOrderedAscending;
	} else {
		return NSOrderedSame;
	}


}


- (double) getX
{
	return x;
}

- (point *) getPt
{
	return p;
}

- (bool) isValid
{
	return valid;
}

- (arc *) getArc
{
	return a;
}

@end
