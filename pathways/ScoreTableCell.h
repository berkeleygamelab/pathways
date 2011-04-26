//
//  scoreTableCell.h
//  Pathways
//
//  Created by Berkeley Game Lab on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScoreTableCell : UITableViewCell {
	
	NSMutableArray *columns;
}

- (void)addColumn:(CGFloat)position;

@end
