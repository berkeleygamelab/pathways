//
//  scoreTableCell.m
//  Pathways
//
//  Created by Berkeley Game Lab on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreTableCell.h"


@implementation ScoreTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		columns = [NSMutableArray arrayWithCapacity:5];
		[columns retain];
		
    }
    return self;
}

-(void)addColumn:(CGFloat) position{
	[columns addObject:[NSNumber numberWithFloat:position]];
}

-(void)drawRect:(CGRect)rect{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0); 
	CGContextSetLineWidth(ctx, 0.25);
	for (int i = 0; i < [columns count]; i++) {
		// get the position for the vertical line
		CGFloat f = [((NSNumber*) [columns objectAtIndex:i]) floatValue];
		CGContextMoveToPoint(ctx, f, 0);
		CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
	}
	
	CGContextStrokePath(ctx);
	
	[super drawRect:rect];
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
