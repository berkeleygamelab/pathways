//
//  Cell.h
//  voron
//
//  Created by Rahul Kartikeya Gupta on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Seg.h"
#import "RightUnMovable.h"
#import "point.h"
#import "RightMovable.h"

@interface RightCell : NSObject {
	RightUnMovable * piece1;
	RightMovable *piece2;
	NSMutableArray *segs;
	point *pt;
	double X0,X1,Y0,Y1;
	double red,blue,green;
	double pos;
}

@property(nonatomic, retain) RightUnMovable* piece1;
@property(nonatomic, retain) RightMovable* piece2;
@property(nonatomic, assign) double X0;
@property(nonatomic, assign) double X1;
@property(nonatomic, assign) double Y0;
@property(nonatomic, assign) double Y1;

- (id)initWithSegs:(NSMutableArray *)segz andPt:(point *) pointt  andPos:(double) position;


@end
