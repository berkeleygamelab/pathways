//
//  Cell.m
//  voron
//
//  Created by Rahul Kartikeya Gupta on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RightCell.h"


@implementation RightCell

@synthesize piece1;
@synthesize piece2;
@synthesize X0;
@synthesize X1;
@synthesize Y0;
@synthesize Y1;

- (id)initWithSegs:(NSMutableArray *)segz andPt:(point *) pointt  andPos:(double) position
{
	
    self = [super init];
    //self = [super initWithFrame:frame];
	if (self) {
		X0 = pointt->x;
		X1 = 0;
		Y0 = pointt->y;
		Y1 = 0;
		Seg *s1, *s2;
		point *p1, *p2, *start, *end;
		pt = pointt;
		NSMutableArray* segments = [[NSMutableArray alloc] initWithArray:segz];
		s1 = (Seg*) [segments objectAtIndex:0];
		pos = position;
		segs = [[NSMutableArray alloc] initWithCapacity:10];
		int count = [segments count];
		[segs addObject:s1];
		[segments removeObjectAtIndex:0];
		
		
		UIBezierPath* aPath = [UIBezierPath bezierPath];
		[aPath moveToPoint:CGPointMake(s1->start->x, s1->start->y)];
		
		for (int i = 0; i <count-1; i++) {
			s1 = (Seg *)[segs objectAtIndex:i];
			end = s1->end;
			start = s1->start;
			for (int j = 0; j < [segments count]; j++) {
				if (j > [segments count]) {
					break;
				}
				s2 = (Seg *)[segments objectAtIndex:j];
				p1 = s2->start;
				p2 = s2->end;
				if (end->x == p1->x && end->y==p1->y) {
					[segs addObject:s2];
					[segments removeObjectAtIndex:j];
					j = [segments count];
					
				}
				if (end->x == p2->x && end->y==p2->y) {
					[segs addObject:[[Seg alloc] initWithStart:p2 andEnd:p1]];
					[segments removeObjectAtIndex:j];
					j = [segments count];
				}
			}
			
			
		}
		
		for (int k = 0; k < [segs count]; k++) {
			s2 = (Seg *)[segs objectAtIndex:k];
			p1 = s2->start;
			p2 = s2->end;
			double x0 = p1->x;
			double y0 = p1->y;
			double x1 = p2->x;
			double y1 = p2->y;
			//NSLog(@"x0: %f x1: %f y0: %f y1: %f",x0,x1,y0,y1);
			//NSLog(@"X0: %f X1: %f Y0: %f Y1: %f",X0,X1,Y0,Y1);
			if (x0 < X0) X0 = x0;
			if (x1 < X0) X0 = x1;
			if (x1 > X1) X1 = x1;
			if (x0 > X1) X1 = x0;
			if (y0 < Y0) Y0 = y0;
			if (y1 < Y0) Y0 = y1;
			if (y0 > Y1) Y1 = y0;
			if (y1 > Y1) Y1 = y1;
			//NSLog(@"X0: %f X1: %f Y0: %f Y1: %f",X0,X1,Y0,Y1);
		}
		
		X0 = X0 - 10;
		Y0 = Y0 - 10;
		green = (double)(arc4random()%255)/(double)(255);
		red = (double)(arc4random()%255)/(double)(255);
		blue = (double)(arc4random()%255)/(double)255;
		//NSLog(@"%f %f %f",red, green, blue);
		piece1 = [[RightUnMovable alloc] initWithFrame:CGRectMake(X0, Y0, 1.5*(X1-X0), 1.5*(Y1-Y0))
											  andSegs:segs
												andPt:pt
											 andColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
		piece2 = [[RightMovable alloc] initWithFrame:CGRectMake(700, pos, 1.5*(X1-X0), 1.5*(Y1-Y0))
											andSegs:segs
											  andPt:pt
											 andNum:1
										   andFrame:CGRectMake(X0, Y0, 1.5*(X1-X0), 1.5*(Y1-Y0))
										   andColor:[UIColor colorWithRed:red green:green blue:blue alpha:.8]];
		//frame = CGRectMake(X0, Y0, (X1-X0), (Y1-Y0));
		//make everything but the shape see-through
		//NSLog(@"bye");
    }
    return self;
	
	
}





@end
