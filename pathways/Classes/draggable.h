//
//  draggable.h
//  game
//
//  Created by Berkeley Game Lab on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface draggable : UIImageView {
	BOOL canMove;
	BOOL active;
	int finalLocX;
	int finalLocY;
	int initLocX;
	int initLocY;
	UIViewController* containingview;
	
}

@property (nonatomic, retain) UIViewController* containingview;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) int initLocX;
@property (nonatomic, assign) int initLocY;

- (id)initWithFrame:(CGRect)frame withFinalX:(int)finalX withFinalY:(int)finalY;
- (id)initWithImage:(UIImage *)image withInitX:(int)initX withInitY:(int)initY withFinalX:(int)finalX withFinalY:(int)finalY;
- (void)snapIntoPlaceAtX:(int)finalX AtY:(int)finalY;
- (void)reactivate;
- (void)playSound;

@end
