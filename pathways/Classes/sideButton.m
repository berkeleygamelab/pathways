//
//  sideButton.m
//  game
//
//  Created by Berkeley Game Lab on 10/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "sideButton.h"

@implementation sideButton


@synthesize touched;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		touched = NO;
    }
    return self;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	touched = YES;
	NSLog(@"side button touched");
	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event {
	touched = NO;
	NSLog(@"side button touch ended");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
