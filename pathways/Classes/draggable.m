//
//  draggable.m
//  game
//
//  Created by Berkeley Game Lab on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "draggable.h"


@implementation draggable

@synthesize containingview;
@synthesize canMove, active;
@synthesize initLocX, initLocY;
@synthesize scaledHeight;

CGPoint startLocation;

- (id)initWithFrame:(CGRect)frame withFinalX:(int)finalX withFinalY:(int)finalY{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		canMove = YES;
		active = NO;
		finalLocX = finalX;
		finalLocY = finalY;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image withInitX:(int)initX withInitY:(int)initY withFinalX:(int)finalX withFinalY:(int)finalY{
	if ((self = [super initWithImage:image])){
		canMove = YES;
		active = NO;
		finalLocX = finalX;
		finalLocY = finalY;	
		initLocX = initX;
		initLocY = initY;
		needScaling = NO;
	}
	return self;
}

- (id)initWithImage:(UIImage *)image withInitX:(int)initX withInitY:(int)initY 
		 withFinalX:(int)finalX withFinalY:(int)finalY scaleToHeight:(int)height{
	if ((self = [super initWithImage:image])){
		canMove = YES;
		active = NO;
		finalLocX = finalX;
		finalLocY = finalY;	
		initLocX = initX;
		initLocY = initY;
		CGRect frame = [self frame];
		origH = (float)frame.size.height;
		origW = (float)frame.size.width;
		scaledHeight = height;
		needScaling = YES;
	}
	return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	if (canMove){
		// Retrieve the touch point
		active = YES;
		CGPoint pt = [[touches anyObject] locationInView:self];
		startLocation = pt;
		[[self superview] bringSubviewToFront:self];
		[self showShadow];
		if (needScaling) {
			[self scaleImageLarger];
		}
	}
}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	if (canMove && active) {
		// Move relative to the original touch point
		CGPoint pt = [[touches anyObject] locationInView:self];
		CGRect frame = [self frame];
		frame.origin.x += pt.x - startLocation.x;
		frame.origin.y += pt.y - startLocation.y;
		/*
		if (frame.origin.x > 100 & frame.origin.x < 200 & frame.origin.y > 100 & frame.origin.y < 200) {
			NSLog(@"in range");
			canMove = NO;
		}
		 */
		[self setFrame:frame];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event {
	if(canMove && active){
		active = NO;
		CGPoint lastTouch = [[touches anyObject] locationInView:self];
		CGRect frame = [self frame];
		frame.origin.x += lastTouch.x - startLocation.x;
		frame.origin.y += lastTouch.y - startLocation.y;
		[self hideShadow];
		if (frame.origin.x > finalLocX-20 & frame.origin.x < finalLocX+20 & frame.origin.y > finalLocY-20 & frame.origin.y < finalLocY+20) {
			[self snapIntoPlaceAtX:finalLocX AtY: finalLocY];
		} else {
			[containingview pieceMisplacedAction:self];
		}
	}
}

- (void)snapIntoPlaceAtX:(int)finalX AtY:(int)finalY {
	CGRect frame = [self frame];
	frame.origin.x = finalX;
	frame.origin.y = finalY;
	self.frame = frame;
	canMove = NO;
	[self playSound];
	[containingview piecePlacedAction:self];
}

- (void)reactivate{
	self.canMove = YES;
}

- (void)scaleImageSmaller{
	float scaleAmount = ((float)scaledHeight/origH);
	NSLog(@"%f / %f = scale by %f", origH, (float)scaledHeight, scaleAmount);
	self.contentMode = UIViewContentModeScaleAspectFit;
	float scaledWidth = (origW * scaleAmount);
	[self setFrame:CGRectMake(initLocX, initLocY, scaledWidth, scaledHeight)];
}

-(void)scaleImageLarger{
	[self setFrame:CGRectMake(initLocX, initLocY, origW, origH)];
}

- (void)showShadow{
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOffset = CGSizeMake(0, 3);
	self.layer.shadowOpacity = 0.8;
	self.layer.shadowRadius = 3.0;
}

-(void)hideShadow{
	self.layer.shadowOpacity = 0;
}

- (void) playSound{
	NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/gem_china_edit_3.aif"];
	SystemSoundID soundID;
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	AudioServicesPlaySystemSound(soundID);
}

- (void)dealloc {
    [super dealloc];
}


@end
