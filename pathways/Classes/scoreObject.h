//
//  scoreObject.h
//  Pathways
//
//  Created by Berkeley Game Lab on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface scoreObject : NSObject{
	NSString *playerName;
	int rightScore;
	int leftScore;
	int totalScore;
	NSDate *startTime;
}

@property (nonatomic, retain) NSString *playerName;
@property (nonatomic, assign) int rightScore;
@property (nonatomic, assign) int leftScore;
@property (nonatomic, assign) int totalScore;
@property (nonatomic, retain) NSDate *startTime;

-(void) addToRightScore:(int)moveScore;
-(void) addToLeftScore:(int)moveScore;


@end
