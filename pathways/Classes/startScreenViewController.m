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

@synthesize draggable1, player1Draggable;
@synthesize level1ViewController, level2ViewController;
@synthesize gamestate;
@synthesize aScoreViewController;
@synthesize player1Button;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.gamestate = STARTSCREEN;
		//[self createDraggable];
		
    }
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

-(void) createDraggable {
	draggable1 = [[draggable alloc] initWithImage:[UIImage imageNamed:@"start-piece.png"] withInitX:720 withInitY:130 withFinalX:336 withFinalY:147];
	[draggable1 setFrame:CGRectOffset([draggable1 frame], 720, 130)];
	[draggable1 setUserInteractionEnabled:YES];
	[self.view addSubview:draggable1];
	draggable1.containingview = self;
	[draggable release];
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

-(IBAction)player1Pressed:(UIButton *)sender{
	NSLog(@"player 1 button pressed");
	player1Button.hidden=YES;
	player1Draggable = [[draggable alloc] initWithImage:[UIImage imageNamed:@"green-peg.png"] withInitX:600 withInitY:126 withFinalX:181 withFinalY:156];
	[player1Draggable setFrame:CGRectOffset([player1Draggable frame], 600, 126)];
	[player1Draggable setUserInteractionEnabled:YES];
	[self.view addSubview:player1Draggable];
	player1Draggable.containingview=self;
	[player1Draggable release];
}

-(IBAction)scoreButtonPressed:(UIButton *)sender {
	scoreViewController *aViewController = [[scoreViewController alloc] initWithNibName:@"scoreViewController" bundle:[NSBundle mainBundle]];
	self.aScoreViewController = aViewController;
	[aViewController release];
	UIView *ScoresView = [aScoreViewController view];
	[self.view addSubview:ScoresView];
	
}

 
-(void)piecePlacedAction:(draggable *)piece{
	player1Draggable.alpha = 0.0;
	player1Button.hidden = NO;
	//[self createDraggable];
	[self makeLevel2WithLevelData:@"level_02_data" withLeftScore:0 withRightScore:0 withScore:0];
	[self makeLevel1WithLevelData:@"level_01_data" withLeftScore:0 withRightScore:0 withScore:0];
}

-(void)makeLevel1WithLevelData:(NSString *) levelData withLeftScore:(int)oldLeftScore withRightScore:(int)oldRightScore withScore:(int)oldTotalScore{
	LevelViewController *aViewController = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:[NSBundle mainBundle] withLevelData:levelData
																		  withLeftScore:oldLeftScore withRightScore:oldRightScore withScore:oldTotalScore];
	self.level1ViewController = aViewController;
	[aViewController release];
	UIView *Level1View = [level1ViewController view];
	[self.view addSubview:Level1View];
	NSLog(@"here doin some stuff");
}
-(void)makeLevel2WithLevelData:(NSString *) levelData withLeftScore:(int)oldLeftScore withRightScore:(int)oldRightScore withScore:(int)oldTotalScore{
	LevelViewController *aViewController = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:[NSBundle mainBundle] withLevelData:levelData
																		  withLeftScore:oldLeftScore withRightScore:oldRightScore withScore:oldTotalScore];
	self.level2ViewController = aViewController;
	[aViewController release];
	UIView *Level2View = [level2ViewController view];
	[self.view addSubview:Level2View];
}

-(void)pieceMisplacedAction:(draggable *)piece{
}

- (void)dealloc {
	[draggable1 dealloc];
	[level1ViewController dealloc];
    [super dealloc];
}


@end
