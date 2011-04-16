//
//  scoreObject.m
//  Pathways
//
//  Created by Berkeley Game Lab on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "scoreObject.h"


@implementation scoreObject

@synthesize playerName, rightScore, leftScore, totalScore, startTime;

- (id)initWithPlayer:(NSString *)player {
    playerName = player;
	rightScore = 0;
	leftScore = 0;
	totalScore = 0;
	
	NSDate *now = [[NSDate alloc] init];
	startTime = now;
    
    return self;
}

-(void) addToRightScore:(int)moveScore{
	rightScore = rightScore + moveScore;
	totalScore = totalScore + moveScore;
}

-(void) addToLeftScore:(int)moveScore{
	leftScore = leftScore + moveScore;
	totalScore = totalScore + moveScore;
}

- (void)dealloc {
    //[super dealloc];
}


@end
