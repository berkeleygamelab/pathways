//
//  Seg.m
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Seg.h"


@implementation Seg

-(id) initWithPoint: (point *) p {
	//NSLog(@"initializing segment");
	self = [super init];
	if (self) {
		start = p;
		end = [[point alloc] init];
		done = NO;
		
	}
	return self;
	
	
}

-(id) initWithStart: (point *) p1 andEnd:(point *) p2
{
	self = [super init];
	if (self) {
		start = p1;
		end = p2;
		done = YES;
	}
	return self;
	
}
- (void) finish: (point *) p
{
	if (done) {
		return;
	}
	end = [[point alloc] initWithPt:p];
	done = YES;
}
	
	
- (void) round
{
	start->x = round(start->x);
	start->y = round(start->y);
	end->x = round(end->x);
	end->y = round(end->y);
}

@end
