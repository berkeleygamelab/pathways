//
//  NonMovable.m
//  voron
//
//  Created by Rahul Kartikeya Gupta on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RightMovable.h"


@implementation RightMovable


- (id)initWithFrame:(CGRect)frame andSegs:(NSMutableArray *) segments andPt:(point *) pointt andNum:(int)number andFrame:(CGRect)frame2 andColor:(UIColor *) clr

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
	
    //self = [super initWithFrame:CGRectMake(X0, Y0, 1.1*(X1-X0), 1.1*(Y1-Y0))];
    self = [super initWithFrame:frame];
	if (self) {
		endFrame = frame2;
		X0 = frame2.origin.x;
		Y0 = frame2.origin.y;
		X1 = frame2.size.width;
		Y1 = frame2.size.height;
		startFrame = frame;
		aPath = [[UIBezierPath bezierPath] retain];
		num = number;
		pt = pointt;
		segs = [[NSMutableArray alloc] initWithArray: segments];
		//frame = CGRectMake(X0, Y0, (X1-X0), (Y1-Y0));
		//make everything but the shape see-through
		[self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
		//NSLog(@"bye");
		color = [[UIColor alloc] initWithCGColor:clr.CGColor];
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
	//	CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
	//	//Set the width of the pen mark
	//	CGContextSetLineWidth(context, 5.0);
	//
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
	
	// Set the starting point of the hape.
	Seg *s;
	// Draw the lines
	s = (Seg *)[segs
				objectAtIndex:0];
	[aPath moveToPoint:CGPointMake((s->start->x - X0), s->start->y - Y0)];
	for (int i = 0; i < [segs count]; i++) {
		s = (Seg *)[segs objectAtIndex:i];
		//[aPath moveToPoint:CGPointMake(s->start->x - X0, s->start->y - Y0)];
		[aPath addLineToPoint:CGPointMake((s->start->x - X0), s->start->y - Y0)];
		[aPath addLineToPoint:CGPointMake((s->end->x - X0), s->end->y - Y0)];
		//[aPath addLineToPoint:CGPointMake(s->start->x, s->start->y)];
		//		[aPath addLineToPoint:CGPointMake(s->end->x, s->end->y)];
	}
	//	CGRect bounds = [self bounds];
	//	CGFloat hx = bounds.size.width / 2.0;
	//	CGFloat hy = bounds.size.height / 2.0;
	//CGContextTranslateCTM(aRef, hx, hy);
	
	//	[aPath moveToPoint:CGPointMake(0,0)];
	//	[aPath addLineToPoint:CGPointMake(0,Y1-Y0)];
	//	[aPath addLineToPoint:CGPointMake(X1-X0,Y1-Y0)];
	//	[aPath addLineToPoint:CGPointMake(X1-X0,0)];
	//	[aPath addLineToPoint:CGPointMake(0,0)];
	CGContextFillRect(aRef, CGRectMake(pt->x+X0, pt->y+Y0, 4.0 , 4.0));
	
	
    
	//CGContextFillRect(aRef, CGRectMake(20, 20, 7.0 , 7.0));
	//CGContextTranslateCTM(aRef, 50, 50);
	
    // Adjust the drawing options as needed.
    aPath.lineWidth = 5;
	
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [aPath fill];
    [aPath stroke];
	//	CGContextRef ctx = UIGraphicsGetCurrentContext();
	//    CGContextClearRect(ctx, rect);
	//	CGContextSetRGBFillColor(ctx, 255, 0, 0, 1);
	//    CGContextFillRect(ctx, CGRectMake(0, 0, 50, 50));
	
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	if(![aPath containsPoint:[[touches anyObject] locationInView:self]] || [self doesMatch]) return;
	//CGContextRef aRef = UIGraphicsGetCurrentContext();
	NSLog(@"%@",aRef);	
	NSLog(@"%@",event);
	CGPoint ptt = [[touches anyObject] locationInView:self];
	startLocation = ptt;
	[[self superview] bringSubviewToFront:self];
}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	if(![aPath containsPoint:[[touches anyObject] locationInView:self]] || [self doesMatch]) return;
	// Move relative to the original touch point
	CGPoint ptt = [[touches anyObject] locationInView:self];
	CGRect frame1 = [self frame];
	frame1.origin.x += ptt.x - startLocation.x;
	frame1.origin.y += ptt.y - startLocation.y;
	/*
	 if (frame.origin.x > 100 & frame.origin.x < 200 & frame.origin.y > 100 & frame.origin.y < 200) {
	 NSLog(@"in range");
	 canMove = NO;
	 }
	 */
	[self setFrame:frame1];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event {
	if(![aPath containsPoint:[[touches anyObject] locationInView:self]] || [self doesMatch]) return;
	NSLog(@"@",aPath);
	CGPoint lastTouch = [[touches anyObject] locationInView:self];
	CGRect frame1 = [self frame];
	frame1.origin.x += lastTouch.x - startLocation.x;
	frame1.origin.y += lastTouch.y - startLocation.y;
	
	
}

- (BOOL) doesMatch
{
	if (abs([self frame].origin.x - X0) <= 5 && abs([self frame].origin.y - Y0) <= 5) {
		[self setFrame:endFrame];
		return YES;
	}
	[self setFrame:startFrame];
	return NO;
}

- (void)dealloc {
    [super dealloc];
}


@end
