//
//  test2.m
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftUnMovable.h"


@implementation LeftUnMovable

- (id)initWithFrame:(CGRect)frame1 andSegs:(NSMutableArray *) segments andPt:(point *) pointt andColor:(UIColor *) clr
{
//
//	X0 = pointt->x;
//	X1 = 0;
//	Y0 = pointt->y;
//	Y1 = 0;
//	Seg *s;
//	point *p1, *p2;
//
//	for (int i =0 ; i <[segments count]; i++) {
//		s = (Seg *)[segments objectAtIndex:i];
//		p1 = s->start;
//		p2 = s->end;
//		double x0 = p1->x;
//		double y0 = p1->y;
//		double x1 = p2->x;
//		double y1 = p2->y;
//		NSLog(@"x0: %f x1: %f y0: %f y1: %f",x0,x1,y0,y1);
//		NSLog(@"X0: %f X1: %f Y0: %f Y1: %f",X0,X1,Y0,Y1);
//		if (x0 < X0) X0 = x0;
//		if (x1 < X0) X0 = x1;
//		if (x1 > X1) X1 = x1;
//		if (x0 > X1) X1 = x0;
//		if (y0 < Y0) Y0 = y0;
//		if (y1 < Y0) Y0 = y1;
//		if (y0 > Y1) Y1 = y0;
//		if (y1 > Y1) Y1 = y1;
//		NSLog(@"X0: %f X1: %f Y0: %f Y1: %f",X0,X1,Y0,Y1);
//	}
	
    self = [super initWithFrame:CGRectMake(1024-frame1.origin.x-frame1.size.width,frame1.origin.y,frame1.size.width,frame1.size.height)];
    //self = [super initWithFrame:frame];
	if (self) {
		X0 = frame1.origin.x;
		Y0 = frame1.origin.y;
		X1 = frame1.size.width;
		Y1 = frame1.size.height;
		pt = pointt;
		segs = [[NSMutableArray alloc] initWithArray: segments];
		//frame = CGRectMake(X0, Y0, (X1-X0), (Y1-Y0));
		//make everything but the shape see-through
		[self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
		//NSLog(@"bye");
		color = [[UIColor alloc] initWithCGColor:clr.CGColor];
		//NSLog(@"%@",color.CGColor);

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	//	[[UIColor redColor] setFill];
	//	
	//	//Get the CGContext from this view
	//	CGContextRef context = UIGraphicsGetCurrentContext();
	//	//Set the stroke (pen) color
	
	//	//Set the width of the pen mark
	//	CGContextSetLineWidth(context, 5.0);
	//NSLog(@"%@",color.CGColor);
	//	
	//	// Draw a line
	//	//Start at this point
	//	CGContextMoveToPoint(context, 0.0, 0.0);
	//	
	//	//Give instructions to the CGContext
	//	//(move "pen" around the screen)
	//	CGContextAddLineToPoint(context, 10.0, 30.0);
	//	CGContextAddLineToPoint(context, 20.0, 40.0);
	//	CGContextAddLineToPoint(context, 0.0, 50.0);
	//	
	//	//Draw it
	//	CGContextStrokePath(context);
	aRef = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(aRef, color.CGColor);
	CGContextSetStrokeColorWithColor(aRef, [UIColor blackColor].CGColor);
	
	UIBezierPath* aPath = [UIBezierPath bezierPath];
	
	// Set the starting point of the hape.
	Seg *s;
	// Draw the lines
	s = (Seg *)[segs objectAtIndex:0];
	[aPath moveToPoint:CGPointMake(-(s->start->x - X0 - X1 - .5), s->start->y - Y0 - .5)];
	for (int i = 0; i < [segs count]; i++) {
		s = (Seg *)[segs objectAtIndex:i];
		if (i == 0) {
			
		}
		//[aPath moveToPoint:CGPointMake(s->start->x - X0, s->start->y - Y0)];
		[aPath addLineToPoint:CGPointMake(-(s->start->x - X0 - X1 - .5), s->start->y - Y0 - .5)];
		[aPath addLineToPoint:CGPointMake(-(s->end->x - X0 - X1 - .5), s->end->y - Y0 - .5)];
		//[aPath addLineToPoint:CGPointMake(s->start->x, s->start->y)];
//		[aPath addLineToPoint:CGPointMake(s->end->x, s->end->y)];
	}
//	CGRect bounds = [self bounds];
//	CGFloat hx = bounds.size.width / 2.0;
//	CGFloat hy = bounds.size.height / 2.0;
	//CGContextTranslateCTM(aRef, hx, hy);
	
//	[aPath moveToPoint:CGPointMake(0,0)];
//	[aPath addLineToPoint:CGPointMake(0,Y1)];
//	[aPath addLineToPoint:CGPointMake(X1,Y1)];
//	[aPath addLineToPoint:CGPointMake(X1,0)];
//	[aPath addLineToPoint:CGPointMake(0,0)];
	//CGContextFillRect(aRef, CGRectMake(pt->x-X0, pt->y-Y0, 4.0 , 4.0));
		
	
    
	//CGContextFillRect(aRef, CGRectMake(20, 20, 7.0 , 7.0));
	//CGContextTranslateCTM(aRef, 50, 50);
	
    // Adjust the drawing options as needed.
    aPath.lineWidth = 4;
	
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [aPath fill];
    [aPath stroke];
	
	//	CGContextRef ctx = UIGraphicsGetCurrentContext();
	//    CGContextClearRect(ctx, rect);
	//	CGContextSetRGBFillColor(ctx, 255, 0, 0, 1);
	//    CGContextFillRect(ctx, CGRectMake(0, 0, 50, 50));
	
}



- (void)dealloc {
    [super dealloc];
}

@end
