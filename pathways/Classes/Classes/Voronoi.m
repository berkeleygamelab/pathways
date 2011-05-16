//
//  Voronoi.m
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Voronoi.h"


@implementation Voronoi

-(id) initWithCells:(NSDictionary *)cls{
	self = [super init];
	if (self)
	{
		//*root = [[arc alloc] init];
		cells = cls;
		X0 = 0;
		X1 = 320;
		Y0 = 0;
		Y1 = 480;
		SEL ptComparator = @selector(greaterThan:);
		points = [[JAPriorityQueue alloc] initWithComparator:ptComparator];
		events = [[JAPriorityQueue alloc] initWithComparator:@selector(greaterThan:)];
		output = [[NSMutableArray alloc] initWithCapacity: 100];
	}
	return self;
	
}

- (void) processPoint
{
//	point* p;
//	int j = [points count];
//	for (int i = 0; i < j; i++) {
//		p = (point *)[points peekAtNextObject];
//		[points removeNextObject];
//		NSLog(@"processing %f %f", p->x, p->y);
//	}
	point* p = (point *)[points peekAtNextObject];
	[points removeNextObject];
	//NSLog(@"processing %f %f", p->x, p->y);
	[self frontInsert:p];
}


- (void) processEvent
{
	event* e = (event *) [events peekAtNextObject];
	[events removeNextObject];
	//NSLog(@"processing event %f", e->x);
	if ([e isValid]) {
		Seg *s = [[Seg alloc] initWithPoint:[e getPt]];
		if (![output containsObject:s]) {
			[output addObject:s];
		}
		
		arc *a = [e getArc];
		
		if (a->prev) {
			a->prev->next = a->next;
			a->prev->s1 = s;
			if (a->prev->p->used == YES) {
				//NSLog(@"use this segment");
				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[a->prev->p toString]];
				[segs addObject:s];
			}
		}
		if (a->next) {
			a->next->prev = a->prev;
			a->next->s0 = s;
			if (a->next->p->used == YES) {
				//NSLog(@"use this segment");
				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[a->next->p toString]];
				[segs addObject:s];
			}
		}
		if (a->s0) 
		{
			[a->s0 finish:(e->p)];
			if (a->p->used == YES) {
//				NSLog(@"use this segment");
//				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[a->p toString]];
//				[segs addObject:a->s0];
			}
		}
		if (a->s1) 
		{
			[a->s1 finish:(e->p)];
//			if (a->p->used == YES) {
//				NSLog(@"use this segment");
//				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[a->p toString]];
//				[segs addObject:a->s1];
//			}
		}
		
		
		
		// Recheck circle events on either side of p:
		if (a->prev) [self checkCircleEvent:(a->prev) andX:(e->x)];
		if (a->next) [self checkCircleEvent:(a->next) andX:(e->x)];
	}
	
}

- (void) frontInsert:(point *)p
{
	//NSLog(@"inserting point %f, %f", p->x, p->y);
	if (rt == NULL) {
		rt = [[arc alloc] initWithPt:p];
		return;
	}
	//NSLog(@"%f",p->x);
	point* pp = p;
	for (arc *i = rt; i; i=i->next) {
		point *z = [[point alloc] init];
		point *zz = [[point alloc] init];
		BOOL inter = [self intersect:pp andI:i andP:z];
		if (inter) {
			//NSLog(@"intersect!");
			if (i->next && ![self intersect:pp andI:i->next	andP:zz]) {
				//NSLog(@"next intersect!");
				i->next->prev = [[arc alloc] initWithPt:i->p andPrev:i andNext:i->next];
				i->next = i->next->prev;
			}
			else {
				i->next = [[arc alloc] initWithPt:i->p andPrev:i];
			}
			//NSLog(@"%f",p->x);
			//i->next->s1 = [[Seg alloc] init];
			i->next->s1 = i->s1;
//			if (i->next->p->used) {
//				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[i->next->p toString]];
//				[segs addObject:i->next->s1];
//			}
			i->next->prev = [[arc alloc] initWithPt:pp andPrev: i andNext:i->next];
			i->next = i->next->prev;
			i = i->next;
			
			Seg *s1 = [[Seg alloc] initWithPoint:z];
			i->prev->s1 = i->s0 = s1;
			//NSLog(@"s0 %f %f ", i->s0->start->x, i->s0->start->y);
			
			if (i->p->used == YES) {
				
				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[i->p toString]];
				[segs addObject:i->s0];
				//NSLog(@"use this segment");
			}
			if (i->prev->p->used == YES) {
				//NSLog(@"use this segment");
				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[i->prev->p toString]];
				[segs addObject:i->prev->s1];
			}
			if (![output containsObject:i->s0]) {
				[output addObject:i->s0];
			}
			
			Seg *s2 = [[Seg alloc] initWithPoint:z];
			i->next->s0 = i->s1 = s2;
			
			if (i->next->p->used == YES) {
				//NSLog(@"use this segment");
				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[i->next->p toString]];
				[segs addObject:i->next->s0];
			}
			if (i->p->used == YES) {
				
				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[i->p toString]];
				[segs addObject:i->s1];
				//NSLog(@"use this segment");
			}
			
			//NSLog(@"s1 %f %f ", i->s1->start->x, i->s1->start->y);
			//NSLog(@"z %f %f ", z->x, z->y);
			if (![output containsObject:i->s1]) {
				[output addObject:i->s1];
			}
			
			//NSLog(@"%f",p->x);

			[self checkCircleEvent:i andX:p->x];
			[self checkCircleEvent:i->prev andX:p->x];
			[self checkCircleEvent:i->next andX:p->x];
			return;
		
		}
	}
	arc *j;
	for (j = rt; j->next; j=j->next) ; // Find the last node.
	
	j->next = [[arc alloc] initWithPt:p andPrev:j];
	// Insert segment between p and i
	point* start = [[point alloc] init];
	start->x = X0;
	start->y = (j->next->p->y + j->p->y) / 2;
	Seg *s3 = [[Seg alloc] initWithPoint:start];
	j->s1 = j->next->s0 = s3;
//	if (j->p->used == YES) {
//		NSLog(@"use this segment");
//		NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[j->p toString]];
//		[segs addObject:s3];
//	}
	if (j->next->p->used == YES) {
		//NSLog(@"use this segment");
		NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[j->next->p toString]];
		[segs addObject:s3];
	}
	if (![output containsObject:j->s1]) {
		[output addObject:j->s1];
	}

}

- (BOOL) intersect:(point *)p andI:(arc *)i andP:(point *)result
{
	if (i->p->x == p->x) return NO;
	double a,b;
	if (i->prev) // Get the intersection of i->prev, i.
		a = [self intersection:i->prev->p andP1:i->p andL:p->x]->y;
	if (i->next) // Get the intersection of i->next, i.
		b = [self intersection:i->p andP1:i->next->p andL:p->x]->y;
	if ((!i->prev || a <= p->y) && (!i->next || p->y <= b)) {
		result->y = p->y;
			
		result->x = (i->p->x*i->p->x + (i->p->y-result->y)*(i->p->y-result->y) - p->x*p->x) / (2*i->p->x - 2*p->x);
		////NSLog(@"intersect %f",p->x);
		return YES;
	}
	//NSLog(@"intersect %f",p->x);
	return NO;

}

- (void) checkCircleEvent:(arc *)i andX: (double) x0
{
	//NSLog(@"Checking Circle Event! arc_point: %f, %f and x: %f",i->p->x, i->p->y, x0);
	if (i->e && i->e->x != x0)
		i->e->valid = NO;
	i->e = NULL;
	
	if (!i->prev || !i->next)
		return;
	
	double a = 0;
	double* x = &a;
	point* o = [[point alloc] init];
	
	if ([self circle:i->prev->p andB:i->p andC:i->next->p andX:x andO:o] && *x > x0) 
	{
		// Create new event.
		i->e = [[event alloc] initWithX:*x andP:o andA:i]; 
		[events addObject:i->e];
	}	
}

- (BOOL) circle:(point *)a andB:(point *)b andC:(point *)c andX:(double *)x andO:(point *)o
{
	//NSLog(@"a_x: %f a_y: b_x:%f b_y:%f c_x:%f c_y:%f",a->x,a->y,b->x,b->y,c->x,c->y);
	// Check that bc is a "right turn" from a
	if ((b->x-a->x)*(c->y-a->y) - (c->x-a->x)*(b->y-a->y) > 0) {
		//NSLog(@"bc is right turn from ab");
		return NO;
		
	}
	
	// Algorithm from O'Rourke 2ed p. 189.
	double A = b->x - a->x;  
	double B = b->y - a->y;
	double C = c->x - a->x;
	double D = c->y - a->y;
	double E = A*(a->x+b->x) + B*(a->y+b->y);
	double F = C*(a->x+c->x) + D*(a->y+c->y);
	double G = 2*(A*(c->y-b->y) - B*(c->x-b->x));
	
	if (G == 0) {
		//NSLog(@"points are colinear");
		return NO;
	}// Points are co-linear.
	
	// Point o is the center of the circle.
	o->x = (D*E-B*F)/G;
	o->y = (A*F-C*E)/G;

	
	// o.x plus radius equals max x coordinate.
	//NSLog(@"o.x plus radius equals max x coordinate");
	*x = o->x + sqrt( pow(a->x - o->x, 2) + pow(a->y - o->y, 2) );
	return true;	
}

-(point *) intersection:(point *)p0 andP1:(point *)p1 andL:(double)l
{
	point* res = [[point alloc] init];
	point* p = p0;
	
	double z0 = 2*(p0->x - l);
	double z1 = 2*(p1->x - l);
	
	if (p0->x == p1->x)
		res->y = (p0->y + p1->y) / 2;
	else if (p1->x == l)
		res->y = p1->y;
	else if (p0->x == l) {
		res->y = p0->y;
		p = p1;
	} else {
		// Use the quadratic formula.
		double a = 1/z0 - 1/z1;
		double b = -2*(p0->y/z0 - p1->y/z1);
		double c = (p0->y*p0->y + p0->x*p0->x - l*l)/z0
		- (p1->y*p1->y + p1->x*p1->x - l*l)/z1;
		
		double y = ( -b - sqrt(b*b - 4*a*c) ) / (2*a);
		res->y=y;
	}
	// Plug back into one of the parabola equations.
	res->x=(p->x*p->x + (p->y-res->y)*(p->y-res->y) - l*l)/(2*p->x-2*l);
	return res;
}

- (void) finishEdges
{
	double l = X1 + (X1-X0) + (Y1-Y0);
	
	// Extend each remaining segment to the new parabola intersections.
	for (arc *i = rt; i->next; i = i->next)
		if (i->s1)
		{
			[i->s1 finish:[self intersection:i->p andP1:i->next->p andL:l*2]];
			if (i->p->used == YES) {
				NSMutableArray* segs = (NSMutableArray *)[cells valueForKey:[i->p toString]];
				[segs addObject:i->s1];
				//NSLog(@"use this segment");
			}
		}
}

- (void) printOutput
{
	//NSLog(@"printOutput %f %f %f %f", X0, X1, Y0, Y1);
	Seg *s;
	point *p0, *p1;
	int a = [output count];
	for (int i = 0; i < [output count]; i++) {
		s = (Seg *)[output objectAtIndex:i];
		p0 = s->start;
		p1 = s->end;
		//NSLog(@"%f %f %f %f",p0->x, p0->y, p1->x, p1->y);
	}
}

- (NSMutableArray *) run:(NSArray *)pts
{
	point* p;
	//NSLog(@"running pts %d", [pts count]);
	for (int i = 0; i < [pts count]; i++) {
		//NSLog(@"%d",i);
		p = (point *) [pts objectAtIndex:i];
		[points addObject:p];
//		if (p->x < X0) X0 = p->x;
//		if (p->y < Y0) Y0 = p->y;
//		if (p->x > X1) X1 = p->x;
//		if (p->y > Y1) Y1 = p->y;
	}
	//[self processPoint];
	
	//NSLog(@"points %d", [points count] );
	double dx = (X1-X0+1)/5.0; double dy = (Y1-Y0+1)/5.0;
//	X0 -= dx; 
//	X1 += dx; 
//	Y0 -= dy; 
//	Y1 += dy;
	while ([points count] != 0) {
		if ([events count] != 0 && ((event*)[events peekAtNextObject])->x <= ((point*)[points peekAtNextObject])->x) {
			[self processEvent];
		} else {
			[self processPoint];
		}

	}
	
	while ([events count] != 0) {
		[self processEvent];
	}
	int a = [output count];
	[self finishEdges];
	[self printOutput];
	return output;

	
}

@end
