//
//  Seg.h
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <math.h>
#import <Foundation/Foundation.h>
#import "point.h"

@interface Seg : NSObject {
	@public
		point* start,* end;
		bool done;

}

-(id) initWithPoint: (point *) p;
-(id) initWithStart: (point *) p1 andEnd:(point *) p2;
-(void) finish: (point *) p;
-(void) round;

@end
