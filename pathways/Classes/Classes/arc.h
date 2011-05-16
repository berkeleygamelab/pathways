//
//  arc.h
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "point.h"
#import "event.h"
#import "Seg.h"


@interface arc : NSObject {
	@public
		point* p;
		arc *prev,*next;
		event* e;
		Seg *s0,*s1;
	
	
}

-(id) initWithArc:(arc *) a;

-(id) initWithPt:(point *) pp;

- (id) initWithPt:(point *)pp andPrev:(arc *) pr;


- (id) initWithPt:(point *)pp andPrev:(arc *) pr andNext:(arc *) n;

-(point *) getPt;

-(arc *) getPrev;

-(arc *) getNext;

-(event *) getEvent;

@end
