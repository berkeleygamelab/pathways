//
//  Voronoi.h
//  test2
//
//  Created by Rahul Kartikeya Gupta on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "arc.h"
#import "Seg.h"
#import "JAPriorityQueue.h"
#import "point.h"

@interface Voronoi : NSObject {

	NSDictionary* cells;
	double X0, X1, Y0, Y1;
	arc *rt;
	JAPriorityQueue	*points, *events;
	NSMutableArray* output;
}

-(id) initWithCells:(NSDictionary *)cls;

-(void) processPoint;

-(void) processEvent;

-(void) frontInsert:(point *) p;

-(BOOL) circle:(point *) a andB:(point *) b andC:(point *) c andX:(double *) x andO:(point *) o;

-(void) checkCircleEvent:(arc *)i andX: (double) x0;

-(BOOL) intersect:(point *)p andI:(arc *)i andP:(point *) result;

-(point *) intersection:(point *)p0 andP1:(point *)p1 andL:(double) l;

-(void) finishEdges;

-(void) printOutput;

-(NSMutableArray *) run:(NSArray *) pts;


@end
