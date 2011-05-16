//
//  event.h
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "point.h"

@class arc;

@interface event : NSObject {
	@public
		double x;
		point* p;
		arc* a;
		bool valid;
}

- (double) getX;

- (point *) getPt;

- (arc *) getArc;

- (bool) isValid;

-(id) initWithX:(int)xx andP:(point *)pp andA:(arc *)aa;

-(NSComparisonResult) greaterThan: (event *) e;

@end
