//
//  arc.m
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "arc.h"


@implementation arc





-(id) initWithPt:(point *) pp
{
	self = [super init];
	if (self)
	{
		p = pp;
//		prev = [[arc alloc] init];
//		next = [[arc alloc] init];
//		e = [[event alloc] init];
//		s0 = [[Seg alloc] init];
//		s1 = [[Seg alloc] init];
	}
	return self;
}

- (id) initWithPt:(point *)pp andPrev:(arc *) pr
{
	self = [super init];
	if (self)
	{
		p = pp;
		prev = pr;
//		next = [[arc alloc] init];
//		e = [[event alloc] init];
//		s0 = [[Seg alloc] init];
//		s1 = [[Seg alloc] init];
	}
	return self;
}

- (id) initWithPt:(point *)pp andPrev:(arc *) pr andNext:(arc *) n
{
	self = [super init];
	if (self)
	{
		p = pp;
		prev = pr;
		next = n;
//		e = [[event alloc] init];
//		s0 = [[Seg alloc] init];
//		s1 = [[Seg alloc] init];
	}
	return self;
}
-(id) initWithArc:(arc *)a
{
	self = [super init];
	if (self)
	{
		p = a->p;
		prev = [a getPrev];
		next = [a getNext];
		e = [a getEvent];
	}
	return self;
}

-(point *) getPt 
{
	return p;
}

-(arc *) getPrev
{
	return prev;
}

-(arc *) getNext
{
	return next;
}

-(event *) getEvent
{
	return e;
}

@end
