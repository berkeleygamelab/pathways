    //
//  VoronoiLevelViewController.m
//  Pathways
//
//  Created by Rahul Kartikeya Gupta on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VoronoiLevelViewController.h"


@implementation VoronoiLevelViewController


#define MOVE 512

BOOL leftSideCompleted;
BOOL rightSideCompleted;

@synthesize timerLabel, scoreLabel;
@synthesize timer;
@synthesize leftButton;
@synthesize rightButton;
@synthesize overlayImage;
@synthesize pausedLabel, pressButtonsLabel, blurbLabel, leftArrow, rightArrow, leftSideCompletedLabel, rightSideCompletedLabel;
@synthesize quitAlert,infoAlert;
@synthesize playerScore;
@synthesize gamestate;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withScoreObject:(scoreObject *)theScore{
    NSLog(@"test1");
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	NSLog(@"test1");
    if (self) {
		gamestate = NONEACTIVE;
		self.playerScore = theScore;
		
		leftSideCompleted = NO;
		rightSideCompleted = NO;
		leftSideCompletedLabel.hidden = YES;
		rightSideCompletedLabel.hidden = YES;
		NSLog(@"test");
        // Custom initialization.
		CGRect overlayRect = CGRectMake(0,0,1024,748);
		overlayImage = [[UIImageView alloc] initWithFrame:overlayRect];
		[overlayImage setImage:[UIImage imageNamed:@"overlay-image.png"]];
		overlayImage.alpha = 0.85;
		[self.view addSubview:overlayImage];
		[overlayImage release];
		
		[self setupPuzzle];
		
		numBlocksLeft = [leftPieces count];
		numBlocksRight = [rightPieces count];
		numBlocks = [leftPieces count] + [rightPieces count];
		[self.view sendSubviewToBack:overlayImage];
		[self showOverlay];


    }
    return self;
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

- (void) setupPuzzle
{
	int change = 50 + arc4random()%25;
	pts = [[NSArray alloc] initWithObjects:
		   [[point alloc] initWithX:280 - arc4random()%change  andY:70+350 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:270 - arc4random()%change  andY:70+260 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:250 - arc4random()%change  andY:70+280 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:180 - arc4random()%change  andY:70+240 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:230 - arc4random()%change  andY:70+230 - arc4random()%change andUsed:YES],
		   [[point alloc] initWithX:700 - arc4random()%change andY:70+640 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:120 - arc4random()%change andY:70+200 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:50.0 - arc4random()%change andY:70+320 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:150 - arc4random()%change andY:70+505 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:220 - arc4random()%change andY:70+90 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:350 - arc4random()%change andY:70+510 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:480 - arc4random()%change andY:70+380 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:400 - arc4random()%change andY:70+192 - arc4random()%change andUsed:NO],
		   [[point alloc] initWithX:600 - arc4random()%change andY:70+400 - arc4random()%change andUsed:NO],
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
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:0] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:1] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:2] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:3] toString]],
																  [[NSString alloc] initWithString:[(point *)[pts objectAtIndex:4] toString]],
																  nil]];
	//NSLog(@"pts %d", [pts count]);
	v = [[Voronoi alloc] initWithCells:cells];
	NSMutableArray * segs = [[NSMutableArray alloc] initWithArray:[v run:pts]];
	double pos1 = 10;
	double pos2 = 10;
	rightPieces = [[NSMutableArray alloc] init];
	leftPieces = [[NSMutableArray alloc] init];

	for (int i = 0; i < 5; i++) {
		RightCell *rpiece =[[RightCell alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:i]toString]] 
										  andPt:(point *)[pts objectAtIndex:i]  andPos:pos1];
		LeftCell *lpiece = [[LeftCell alloc] initWithSegs:(NSMutableArray *)[cells valueForKey:[(point *)[pts objectAtIndex:i]toString]] 
													 andPt:(point *)[pts objectAtIndex:i]  andPos:pos2];
		[lpiece.piece1 setUserInteractionEnabled:NO];
		CGRect l1 = lpiece.piece1.frame;
		l1.origin.x -= MOVE;
		lpiece.piece1.frame = l1;
		CGRect l2 = lpiece.piece2.frame;
		l2.origin.x -= MOVE;
		lpiece.piece2.frame = l2;
		CGRect r1 = rpiece.piece1.frame;
		r1.origin.x += MOVE;
		rpiece.piece1.frame = r1;
		CGRect r2 = rpiece.piece2.frame;
		r2.origin.x += MOVE;
		rpiece.piece2.frame = r2;
		[lpiece.piece2 setUserInteractionEnabled:YES];
		[rpiece.piece1 setUserInteractionEnabled:NO];
		[rpiece.piece2 setUserInteractionEnabled:YES];
		[self.view addSubview:rpiece.piece1];
		[self.view addSubview:rpiece.piece2];
		[self.view addSubview:lpiece.piece1];
		[self.view addSubview:lpiece.piece2];

		lpiece.piece1.alpha=0.20;
		lpiece.piece2.alpha=0.60;
		rpiece.piece1.alpha=0.20;
		rpiece.piece2.alpha=0.60;
		
		[rightPieces addObject:rpiece];
		[leftPieces addObject:lpiece];
		
		pos1 += rpiece.Y1 - rpiece.Y0;
		pos2 += lpiece.Y1 - lpiece.Y0;
	}
	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)showOverlay {
	NSLog(@"GAMESTATE: %i", gamestate);
	leftButton.enabled = YES;
	rightButton.enabled = YES;
	

	
	if (gamestate==COMPLETE) {
		blurbLabel.hidden=YES;
		leftArrow.hidden=YES;
		rightArrow.hidden=YES;
		overlayImage.alpha=0.3;
		//[self makeScoreButton];
		
	} else {
		blurbLabel.hidden=NO;
		leftArrow.hidden=NO;
		rightArrow.hidden=NO;
		overlayImage.alpha=0.85;
	}
	pausedLabel.hidden=NO; 
	pressButtonsLabel.hidden=NO;
	leftSideCompletedLabel.hidden=YES;
	rightSideCompletedLabel.hidden=YES;
	

	
}

- (void)hideOverlay {
	//hacky -- to update score
	scoreLabel.text	= [NSString stringWithFormat:@" SCORE: %i", playerScore.totalScore];
	
	overlayImage.alpha=0;
	pausedLabel.hidden=YES; 
	pressButtonsLabel.hidden=YES;
	blurbLabel.hidden=YES;
	leftArrow.hidden=YES;
	rightArrow.hidden=YES;

}


-(IBAction)backButtonPressed:(UIButton *)backButton {
	if((gamestate==NONEACTIVE) || (gamestate==COMPLETE)){
		quitAlert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to quit?" message:nil
											  delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		[quitAlert show];
		[quitAlert release];
	}
}

- (void)alertView : (UIAlertView *)alertView clickedButtonAtIndex : (NSInteger)buttonIndex{	
	if(alertView == quitAlert){
		if(buttonIndex == 0){
		}
		else{
			//startScreen = [[startScreenViewController alloc] initWithNibName:@"startScreenViewController" bundle:[NSBundle mainBundle]];
			[[self navigationController] popToRootViewControllerAnimated:NO];
		}
	}else if (alertView==infoAlert) {
	}
}

-(IBAction)infoButtonPressed:(UIButton *)infoButton {
	if ((gamestate==NONEACTIVE)||(gamestate==COMPLETE)) {
		
		infoAlert = [[UIAlertView alloc] initWithTitle:@"Pathways Information"
											   message:@"Pathways is a puzzle game based on the Purdue Pegboard Test meant to help train the visual and motor skills of people who have suffered damage to the visual or motor cortex. Pathways is played with both hands in order to facilitate recovery of fine motor function. Pathways was created by UC Berkeley's Social App Lab at Citris" 
											  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[infoAlert show];
		[infoAlert release];
	}
}

-(IBAction)leftSideTouchDown:(UIButton *)leftButton{
	
	if(gamestate==NONEACTIVE){
		gamestate = RIGHTACTIVE;
		
		[self hideOverlay];
		rightButton.enabled = FALSE;
		rightButton.hidden = YES;
		
		timerLabel.text = [NSString stringWithFormat:@"%i",rightTime];
		timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countSeconds) userInfo:nil repeats:YES];
		timerLabel.hidden = NO;
		
		[UIView beginAnimations:nil context:NULL]; // Begin animation
		
		
		
		if (rightSideCompleted && (!leftSideCompleted)) {
			rightSideCompletedLabel.hidden=NO;
		}
		
		
		for(LeftCell *lpiece in leftPieces){
			CGRect l1 = lpiece.piece1.frame;
			l1.origin.x -= MOVE;
			lpiece.piece1.frame = l1;
			CGRect l2 = lpiece.piece2.frame;
			l2.origin.x -= MOVE;
			lpiece.piece2.frame = l2;

		}
		for(RightCell * rpiece in rightPieces){
			CGRect r1 = rpiece.piece1.frame;
			rpiece.piece1.alpha = 1;
			r1.origin.x -= MOVE;
			rpiece.piece1.frame = r1;
			CGRect r2 = rpiece.piece2.frame;
			r2.origin.x -= MOVE;
			rpiece.piece2.frame = r2;
		}
		
		[UIView commitAnimations]; // End animations
	}
}


-(IBAction)rightSideTouchDown:(UIButton *)rightButton{
	
	if(gamestate==NONEACTIVE){
		gamestate = LEFTACTIVE;
		
		[self hideOverlay];
		leftButton.enabled = NO;
		leftButton.hidden = YES;
		
		timerLabel.text = [NSString stringWithFormat:@"%i",leftTime];
		timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countSeconds) userInfo:nil repeats:YES];
		timerLabel.hidden = NO;
		
		[UIView beginAnimations:nil context:NULL]; // Begin animation

		
		if (leftSideCompleted && (!rightSideCompleted)) {
			leftSideCompletedLabel.hidden=NO;
		}
		
		
		for(LeftCell *lpiece in leftPieces){
			CGRect l1 = lpiece.piece1.frame;
			l1.origin.x += MOVE;
			lpiece.piece1.alpha = 1;
			lpiece.piece1.frame = l1;
			CGRect l2 = lpiece.piece2.frame;
			l2.origin.x += MOVE;
			lpiece.piece2.frame = l2;
			
		}
		for(RightCell * rpiece in rightPieces){
			CGRect r1 = rpiece.piece1.frame;
			
			r1.origin.x += MOVE;
			rpiece.piece1.frame = r1;
			CGRect r2 = rpiece.piece2.frame;
			r2.origin.x += MOVE;
			rpiece.piece2.frame = r2;
		}
		
		[UIView commitAnimations]; // End animations
	}
}

-(IBAction)leftSideTouchUp:(UIButton *)leftButton{
	[self shiftToCenter];
	rightSideCompletedLabel.hidden=YES;
}

-(IBAction)rightSideTouchUp:(UIButton *)rightButton{
	[self shiftToCenter];
	leftSideCompletedLabel.hidden = YES;
}

-(void)shiftToCenter{
	if(gamestate == RIGHTACTIVE){
		[self leftToCenter];
	}else if (gamestate == LEFTACTIVE) {
		[self rightToCenter];
	}
}


-(void)leftToCenter{
	if (gamestate==RIGHTACTIVE) {
		gamestate=NONEACTIVE;
		
		[self showOverlay];
		rightButton.hidden = NO;
		
		[timer invalidate];
		timerLabel.hidden = YES;
		
		
		[UIView beginAnimations:nil context:NULL]; // Begin animation
		for(LeftCell *lpiece in leftPieces){
			CGRect l1 = lpiece.piece1.frame;
			l1.origin.x += MOVE;
			lpiece.piece1.frame = l1;
			CGRect l2 = lpiece.piece2.frame;
			l2.origin.x += MOVE;
			lpiece.piece2.frame = l2;
			lpiece.piece1.alpha = .2;
			
		}
		for(RightCell * rpiece in rightPieces){
			CGRect r1 = rpiece.piece1.frame;
			rpiece.piece1.alpha = .2;
			r1.origin.x += MOVE;
			rpiece.piece1.frame = r1;
			CGRect r2 = rpiece.piece2.frame;
			r2.origin.x += MOVE;
			rpiece.piece2.frame = r2;
		}
		[UIView commitAnimations]; // End animations
	}
}

-(void)rightToCenter{
	if(gamestate == LEFTACTIVE){
		gamestate = NONEACTIVE;
		
		[self showOverlay];
		leftButton.hidden = NO;
		
		[timer invalidate];
		timerLabel.hidden = YES;
		
		[UIView beginAnimations:nil context:NULL]; // Begin animation

		for(LeftCell *lpiece in leftPieces){
			CGRect l1 = lpiece.piece1.frame;
			l1.origin.x -= MOVE;
			lpiece.piece1.frame = l1;
			CGRect l2 = lpiece.piece2.frame;
			l2.origin.x -= MOVE;
			lpiece.piece2.frame = l2;
			lpiece.piece1.alpha = .2;
			
		}
		for(RightCell * rpiece in rightPieces){
			CGRect r1 = rpiece.piece1.frame;
			rpiece.piece1.alpha = .2;
			r1.origin.x -= MOVE;
			rpiece.piece1.frame = r1;
			CGRect r2 = rpiece.piece2.frame;
			r2.origin.x -= MOVE;
			rpiece.piece2.frame = r2;
		}
		[UIView commitAnimations]; // End animations
	}
}

- (void)dealloc {
    [super dealloc];
}

-(void)countSeconds {
	if((gamestate==LEFTACTIVE) && (leftTime > 0)){
		timerLabel.text = [NSString stringWithFormat:@"%i",--leftTime];
	}
	else if((gamestate == RIGHTACTIVE) && (rightTime > 0)){
		timerLabel.text = [NSString stringWithFormat:@"%i",--rightTime];
	}
	else {
		timerLabel.text = 0;
	}
	
}


@end
