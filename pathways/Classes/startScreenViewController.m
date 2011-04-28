    //
//  startScreenViewController.m
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "startScreenViewController.h"
#import "LevelViewController.h"

@implementation startScreenViewController

@synthesize draggable1, draggable2, draggable3, draggable4, draggable5;
@synthesize gamestate;
@synthesize levelPick;
@synthesize ahighScoreViewController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.gamestate = STARTSCREEN;
		[self createPlayer1Draggable];
		[self createPlayer2Draggable];
		[self createPlayer3Draggable];
		[self createPlayer4Draggable];
		[self createPlayer5Draggable];

		
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self createPlayer1Draggable];
	[self createPlayer2Draggable];
	[self createPlayer3Draggable];
	[self createPlayer4Draggable];
	[self createPlayer5Draggable];
}


-(void) createPlayer1Draggable {
	draggable1 = [[draggable alloc] initWithImage:[UIImage imageNamed:@"green-peg.png"] 
										withInitX:710 withInitY:156 
										withFinalX:46 withFinalY:167
									 scaleToHeight:100];
	[draggable1 setFrame:CGRectOffset([draggable1 frame], 710, 156)];
	[draggable1 setUserInteractionEnabled:YES];
	[self.view addSubview:draggable1];
	draggable1.containingview = self;
	[draggable1 release];
	[draggable1 scaleImageSmaller];
}

-(void) createPlayer2Draggable {
	draggable2 = [[draggable alloc] initWithImage:[UIImage imageNamed:@"blue-peg.png"] 
										withInitX:686 withInitY:263 
									   withFinalX:195 withFinalY:157
									scaleToHeight:90];
	[draggable2 setFrame:CGRectOffset([draggable2 frame], 686, 263)];
	[draggable2 setUserInteractionEnabled:YES];
	[self.view addSubview:draggable2];
	draggable2.containingview = self;
	[draggable2 release];
	[draggable2 scaleImageSmaller];
}

-(void) createPlayer3Draggable {
	draggable3 = [[draggable alloc] initWithImage:[UIImage imageNamed:@"red-peg.png"] 
										withInitX:688 withInitY:362 
									   withFinalX:292 withFinalY:293
									scaleToHeight:94];
	[draggable3 setFrame:CGRectOffset([draggable3 frame], 688, 362)];
	[draggable3 setUserInteractionEnabled:YES];
	[self.view addSubview:draggable3];
	draggable3.containingview = self;
	[draggable3 release];
	[draggable3 scaleImageSmaller];
}

-(void) createPlayer4Draggable {
	draggable4 = [[draggable alloc] initWithImage:[UIImage imageNamed:@"yellow-peg.png"] 
										withInitX:720 withInitY:464 
									   withFinalX:185 withFinalY:254
									scaleToHeight:95];
	[draggable4 setFrame:CGRectOffset([draggable4 frame], 720, 464)];
	[draggable4 setUserInteractionEnabled:YES];
	[self.view addSubview:draggable4];
	draggable4.containingview = self;
	[draggable4 release];
	[draggable4 scaleImageSmaller];
}

-(void) createPlayer5Draggable {
	draggable5 = [[draggable alloc] initWithImage:[UIImage imageNamed:@"purple-peg.png"] 
										withInitX:688 withInitY:576 
									   withFinalX:280 withFinalY:470
									scaleToHeight:58];
	[draggable5 setFrame:CGRectOffset([draggable5 frame], 688, 156)];
	[draggable5 setUserInteractionEnabled:YES];
	[self.view addSubview:draggable5];
	draggable5.containingview = self;
	[draggable5 release];
	[draggable5 scaleImageSmaller];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(IBAction)scoreButtonPressed:(UIButton *)sender {
//	gameAppDelegate *appDelegate = (gameAppDelegate *)[[UIApplication sharedApplication] delegate];
//	[self.view removeFromSuperview];
//	[appDelegate showHighScores];
	highScoreViewController *aViewController = [[highScoreViewController alloc] initWithNibName:@"highScoreViewController" bundle:[NSBundle mainBundle]];
	self.ahighScoreViewController = aViewController;
	[aViewController release];
	[self.navigationController pushViewController:ahighScoreViewController animated:NO];
	
}
 
-(void)piecePlacedAction:(draggable *)piece{
	gameAppDelegate *appDelegate = (gameAppDelegate *)[[UIApplication sharedApplication] delegate];
	scoreObject *playerScore;
	
	[piece scaleImageSmaller];
	piece.canMove = YES;
	if (piece == draggable1) {		
		playerScore = [[scoreObject alloc] initWithPlayer:@"1-10 years"];		
	} else if (piece == draggable2) {
		playerScore = [[scoreObject alloc] initWithPlayer:@"10-17 years"];		
	} else if (piece == draggable3) {
		playerScore = [[scoreObject alloc] initWithPlayer:@"18-29 years"];		
	} else if (piece == draggable4) {
		playerScore = [[scoreObject alloc] initWithPlayer:@"30-55 years"];		
	} else if (piece == draggable5) {
		playerScore = [[scoreObject alloc] initWithPlayer:@"55+ years"];		
	}
	
	
	appDelegate.currentScore = playerScore;
	
//	appDelegate.levelData = @"level_01_data";
	//[self.view removeFromSuperview];
	self.levelPick = [[LevelPickViewController alloc] initWithNibName:@"LevelPickViewController" bundle:[NSBundle mainBundle] andPlayerScore:playerScore];
	NSLog(@"testing");
	[[self navigationController] pushViewController:levelPick animated:YES];
	
//	[appDelegate switchLevel];
	//[self makeLevel2WithLevelData:@"level_02_data" withLeftScore:0 withRightScore:0 withScore:0];
}


-(void)pieceMisplacedAction:(draggable *)piece{
	[piece scaleImageSmaller];
}

- (void)dealloc {
	[draggable1 dealloc];
    [super dealloc];
}


@end
