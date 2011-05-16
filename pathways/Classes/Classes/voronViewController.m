//
//  voronViewController.m
//  voron
//
//  Created by Rahul Kartikeya Gupta on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "voronViewController.h"

@implementation voronViewController



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[self awakeFromNib];
    }
    return self;
}


- (void) awakeFromNib {
	NSLog(@"hello");
	//t1 = [[test alloc] initWithFrame:CGRectMake(0, 10, 250, 270)];   
}
			 

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (IBAction)makeNew:(UIButton *) sender
{	
	for (UIView * subView in [self.view subviews]) {
		if (![subView isKindOfClass:[UIButton class]])
			[subView removeFromSuperview];
	}
	int change = 50 + arc4random()%25;
	//[self.view.subviews release];
	pts = [[NSArray alloc] initWithObjects:
		   [[point alloc] initWithX:120 - arc4random()%change andY:200 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:50.0 - arc4random()%change andY:320 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:150 - arc4random()%change andY:505 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:220 - arc4random()%change andY:90 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:280 - arc4random()%change  andY:350 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:350 - arc4random()%change andY:510 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:700 - arc4random()%change andY:640 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:170 - arc4random()%change  andY:260 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:250 - arc4random()%change  andY:280 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:180 - arc4random()%change  andY:340 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:330 - arc4random()%change  andY:330 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:480 - arc4random()%change andY:380 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:400 - arc4random()%change andY:192 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:600 - arc4random()%change andY:400 - arc4random()%change andUsed:NO],
		   //[[point alloc] initWithX:640 + arc4random()%50 andY:70 + arc4random()%50 andUsed:NO],
		   nil];
	NSDictionary* cells  =[[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects:
																  [[NSMutableArray alloc] initWithCapacity:10],
																  [[NSMutableArray alloc] initWithCapacity:10],
																  [[NSMutableArray alloc] initWithCapacity:10],
																  [[NSMutableArray alloc] initWithCapacity:10],
																  [[NSMutableArray alloc] initWithCapacity:10],
																  nil]
														forKeys: [[NSArray alloc] initWithObjects:
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:4] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:7] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:8] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:9] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:10] toString]],
																  nil]];
	//NSLog(@"pts %d", [pts count]);
	v = [[Voronoi alloc] initWithCells:cells];
	
	NSMutableArray * segs = [[NSMutableArray alloc] initWithArray:[v run:pts]];
	//	mainT = [[bigTest alloc] initWithFrame:CGRectMake(0, 0, 320, 480)
	//			 						   andSegs:segs
	//			 							andPts:pts];
	//			 
	//			 [mainT setUserInteractionEnabled:YES];
	//			 [self.view addSubview:mainT];
	rpiece1 = [[RightCell alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:4]toString]] 
										andPt:(point *)[pts objectAtIndex:4]  andPos:0];
	double pos = rpiece1.Y1 - rpiece1.Y0;
	rpiece2 = [[RightCell   alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:7]toString]] 
										  andPt:(point *)[pts objectAtIndex:7]  andPos:pos];
	pos += rpiece2.Y1 - rpiece2.Y0;
	rpiece3 = [[RightCell   alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:8]toString]] 
										  andPt:(point *)[pts objectAtIndex:8]  andPos:pos];
	pos += rpiece3.Y1 - rpiece3.Y0;
	rpiece4 = [[RightCell   alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:9]toString]] 
										  andPt:(point *)[pts objectAtIndex:9]  andPos:pos];
	pos += rpiece4.Y1 - rpiece4.Y0;
	rpiece5 = [[RightCell  alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:10]toString]] 
										 andPt:(point *)[pts objectAtIndex:10]  andPos:pos];
	
	lpiece1 = [[LeftCell alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:4]toString]] 
									   andPt:(point *)[pts objectAtIndex:4]  andPos:0];
	pos = 0;
	pos = lpiece1.Y1 - lpiece1.Y0;
	lpiece2 = [[LeftCell   alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:7]toString]] 
										 andPt:(point *)[pts objectAtIndex:7]  andPos:pos];
	pos += lpiece2.Y1 - lpiece2.Y0;
	lpiece3 = [[LeftCell   alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:8]toString]] 
										 andPt:(point *)[pts objectAtIndex:8]  andPos:pos];
	pos += lpiece3.Y1 - lpiece3.Y0;
	lpiece4 = [[LeftCell   alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:9]toString]] 
										 andPt:(point *)[pts objectAtIndex:9]  andPos:pos];
	pos += lpiece4.Y1 - lpiece4.Y0;
	lpiece5 = [[LeftCell  alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:10]toString]] 
										andPt:(point *)[pts objectAtIndex:10]  andPos:pos];
	//	[rpiece1.piece1 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece1.piece1];
	//	[rpiece1.piece2 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece1.piece2];
	//	[rpiece2.piece1 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece2.piece1];
	//	[rpiece2.piece2 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece2.piece2];
	//	[rpiece3.piece1 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece3.piece1];
	//	[rpiece3.piece2 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece3.piece2];
	//	[rpiece4.piece1 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece4.piece1];
	//	[rpiece4.piece2 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece4.piece2];
	//	[rpiece5.piece1 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece5.piece1];
	//	[rpiece5.piece2 setUserInteractionEnabled:YES];
	//	[self.view addSubview:rpiece5.piece2];
	[lpiece1.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece1.piece1];
	[lpiece1.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece1.piece2];
	[lpiece2.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece2.piece1];
	[lpiece2.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece2.piece2];
	[lpiece3.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece3.piece1];
	[lpiece3.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece3.piece2];
	[lpiece4.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece4.piece1];
	[lpiece4.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece4.piece2];
	[lpiece5.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece5.piece1];
	[lpiece5.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:lpiece5.piece2];
	[rpiece1.piece1 setUserInteractionEnabled:YES];
	//	[t2 setUserInteractionEnabled:YES];
	//	[self.view addSubview:t2];
	//			[t3 setUserInteractionEnabled:YES];
	//			[self.view addSubview:t3];
	//			 [t3 setUserInteractionEnabled:YES];
	//			 [self.view addSubview:t3];
	//			 [t3 setUserInteractionEnabled:YES];
	//			 [self.view addSubview:t3];
	//			 [t4 setUserInteractionEnabled:YES];
	//			 [self.view addSubview:t4];
	//			 [t5 setUserInteractionEnabled:YES];
	//			 [self.view addSubview:t5];
	//			 [t6 setUserInteractionEnabled:YES];
	//			 [self.view addSubview:t6];
	[v release];
	[pts dealloc];
	[cells dealloc];
}
- (IBAction)showLeft:(UIButton *) sender
{
//	[lpiece1.piece1 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece1.piece1];
//	[lpiece1.piece2 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece1.piece2];
//	[lpiece2.piece1 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece2.piece1];
//	[lpiece2.piece2 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece2.piece2];
//	[lpiece3.piece1 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece3.piece1];
//	[lpiece3.piece2 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece3.piece2];
//	[lpiece4.piece1 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece4.piece1];
//	[lpiece4.piece2 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece4.piece2];
//	[lpiece5.piece1 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece5.piece1];
//	[lpiece5.piece2 setUserInteractionEnabled:YES];
//	[self.view addSubview:lpiece5.piece2];
//	[rpiece1.piece1 setUserInteractionEnabled:YES];
	rpiece1.piece1.hidden = YES;
	rpiece1.piece2.hidden = YES;
	rpiece2.piece1.hidden = YES;
	rpiece2.piece2.hidden = YES;
	rpiece3.piece1.hidden = YES;
	rpiece3.piece2.hidden = YES;
	rpiece4.piece1.hidden = YES;
	rpiece4.piece2.hidden = YES;
	rpiece5.piece1.hidden = YES;
	rpiece5.piece2.hidden = YES;
	lpiece1.piece1.hidden = NO;
	lpiece1.piece2.hidden = NO;
	lpiece2.piece1.hidden = NO;
	lpiece2.piece2.hidden = NO;
	lpiece3.piece1.hidden = NO;
	lpiece3.piece2.hidden = NO;
	lpiece4.piece1.hidden = NO;
	lpiece4.piece2.hidden = NO;
	lpiece5.piece1.hidden = NO;
	lpiece5.piece2.hidden = NO;
//	[rpiece1.piece2 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece1.piece2];
//	[rpiece2.piece1 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece2.piece1];
//	[rpiece2.piece2 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece2.piece2];
//	[rpiece3.piece1 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece3.piece1];
//	[rpiece3.piece2 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece3.piece2];
//	[rpiece4.piece1 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece4.piece1];
//	[rpiece4.piece2 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece4.piece2];
//	[rpiece5.piece1 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece5.piece1];
//	[rpiece5.piece2 setUserInteractionEnabled:YES];
//	[self.view removeSubview:rpiece5.piece2];
	
}

- (IBAction)showRight: (UIButton *) sender
{
	[rpiece1.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece1.piece1];
	[rpiece1.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece1.piece2];
	[rpiece2.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece2.piece1];
	[rpiece2.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece2.piece2];
	[rpiece3.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece3.piece1];
	[rpiece3.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece3.piece2];
	[rpiece4.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece4.piece1];
	[rpiece4.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece4.piece2];
	[rpiece5.piece1 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece5.piece1];
	[rpiece5.piece2 setUserInteractionEnabled:YES];
	[self.view addSubview:rpiece5.piece2];
	lpiece1.piece1.hidden = YES;
	lpiece1.piece2.hidden = YES;
	lpiece2.piece1.hidden = YES;
	lpiece2.piece2.hidden = YES;
	lpiece3.piece1.hidden = YES;
	lpiece3.piece2.hidden = YES;
	lpiece4.piece1.hidden = YES;
	lpiece4.piece2.hidden = YES;
	lpiece5.piece1.hidden = YES;
	lpiece5.piece2.hidden = YES;
	rpiece1.piece1.hidden = NO;
	rpiece1.piece2.hidden = NO;
	rpiece2.piece1.hidden = NO;
	rpiece2.piece2.hidden = NO;
	rpiece3.piece1.hidden = NO;
	rpiece3.piece2.hidden = NO;
	rpiece4.piece1.hidden = NO;
	rpiece4.piece2.hidden = NO;
	rpiece5.piece1.hidden = NO;
	rpiece5.piece2.hidden = NO;
	
	
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
