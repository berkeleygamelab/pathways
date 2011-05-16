
//  Created by Rahul Kartikeya Gupta on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "bigTest.h"


@implementation bigTest

- (id)initWithFrame:(CGRect)frame andSegs:(NSMutableArray *) segments andPts:(NSArray *) points
{
	
	
    //self = [super initWithFrame:CGRectMake(X0, Y0, 1.1*(X1-X0), 1.1*(Y1-Y0))];
    self = [super initWithFrame:frame];
	if (self) {
		segs = [[NSMutableArray alloc] initWithArray: segments];
		pts = [[NSArray alloc] initWithArray: points];
		//frame = CGRectMake(X0, Y0, (X1-X0), (Y1-Y0));
		//make everything but the shape see-through
		[self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
		NSLog(@"bye");
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
	//	CGContextSetFillColor(context, [UIColor redColor].CGColor);
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
	
	UIBezierPath* aPath = [UIBezierPath bezierPath];
	
	// Set the starting point of the hape.
	[aPath moveToPoint:CGPointMake(0.0, 0.0)];
	Seg *s;
	// Draw the lines
	for (int i = 0; i < [segs count]; i++) {
		s = (Seg *)[segs objectAtIndex:i];
		if (i == 0) {
			
		}
		[aPath moveToPoint:CGPointMake(s->start->x, s->start->y)];
		[aPath addLineToPoint:CGPointMake(s->end->x, s->end->y)];
		//[aPath addLineToPoint:CGPointMake(s->start->x, s->start->y)];
		//		[aPath addLineToPoint:CGPointMake(s->end->x, s->end->y)];
	}
	//	CGRect bounds = [self bounds];
	//	CGFloat hx = bounds.size.width / 2.0;
	//	CGFloat hy = bounds.size.height / 2.0;
	//CGContextTranslateCTM(aRef, hx, hy);
	point *p;
	for (int j = 0; j < [pts count]; j++) {
		p = (point *)[pts objectAtIndex:j];
		CGContextFillRect(aRef, CGRectMake(p->x, p->y, 4.0 , 4.0));
	}
	
	
	
    
	//CGContextFillRect(aRef, CGRectMake(20, 20, 7.0 , 7.0));
	//CGContextTranslateCTM(aRef, 50, 50);
	
    // Adjust the drawing options as needed.
    aPath.lineWidth = 2;
	
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    //[aPath fill];
    [aPath stroke];
	
	//	CGContextRef ctx = UIGraphicsGetCurrentContext();
	//    CGContextClearRect(ctx, rect);
	//	CGContextSetRGBFillColor(ctx, 255, 0, 0, 1);
	//    CGContextFillRect(ctx, CGRectMake(0, 0, 50, 50));
	
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	//CGContextRef aRef = UIGraphicsGetCurrentContext();
	NSLog(@"%@",aRef);	
	NSLog(@"%@",event);
	CGPoint ptt = [[touches anyObject] locationInView:self];
	startLocation = ptt;
	[[self superview] bringSubviewToFront:self];
}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	
	// Move relative to the original touch point
	CGPoint ptt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += ptt.x - startLocation.x;
	frame.origin.y += ptt.y - startLocation.y;
	/*
	 if (frame.origin.x > 100 & frame.origin.x < 200 & frame.origin.y > 100 & frame.origin.y < 200) {
	 NSLog(@"in range");
	 canMove = NO;
	 }
	 */
	[self setFrame:frame];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event {
	
	CGPoint lastTouch = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += lastTouch.x - startLocation.x;
	frame.origin.y += lastTouch.y - startLocation.y;
	
	
}


- (void)dealloc {
    [super dealloc];
}

@end
