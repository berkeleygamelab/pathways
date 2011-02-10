    //
//  LevelViewController.m
//  game
//
//  Created by Berkeley Game Lab on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelViewController.h"

#define BOARDWIDTH 436
#define BOARDHEIGHT 675
#define LEFTBOARDACTIVE_X 64
#define BOARD_Y 20
#define RIGHTBOARDACTIVE_X 524
#define OFFBOARDX 500
#define ACROSSBOARD_X 460
#define MAXPIECEPOINTS 30

@implementation LevelViewController

@synthesize gamestate;
@synthesize leftMapBoard, rightMapBoard;
@synthesize leftPieces, rightPieces;
@synthesize leftPieceBoard, rightPieceBoard;
@synthesize timerLabel, scoreLabel;
@synthesize timer;
@synthesize leftButton;
@synthesize rightButton;
@synthesize overlayImage;
@synthesize pausedLabel, pressButtonsLabel, blurbLabel, leftArrow, rightArrow, leftSideCompletedLabel, rightSideCompletedLabel;
@synthesize quitAlert,infoAlert;
@synthesize aScoreViewController, nextLevelViewController;

BOOL leftSideCompleted;
BOOL rightSideCompleted;
BOOL isLastLevel;

//level data
NSString *leftMapImageName;
NSString *rightMapImageName;
NSString *leftPiecesTextFile;
NSString *rightPiecesTextFile;
int numPieces;
NSString *nextLevelData;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLevelData:(NSString *)levelData 
		withLeftScore:(int)oldLeftScore withRightScore:(int)oldRightScore withScore:(int)oldTotalScore{

    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		gamestate = NONEACTIVE;
		leftScore = oldLeftScore;
		rightScore = oldRightScore;
		score = oldTotalScore;
		
		leftSideCompleted = NO;
		rightSideCompleted = NO;
		leftSideCompletedLabel.hidden = YES;
		rightSideCompletedLabel.hidden = YES;
		
		//PARSE LEVEL DATA TEXT FILE
		NSString *levelDataFilePath = [[NSBundle mainBundle] pathForResource:levelData ofType:@"txt"];
		NSString *levelDataFileContents = [NSString stringWithContentsOfFile:levelDataFilePath encoding:NSUTF8StringEncoding error:nil];
		NSArray *levelDataArray = [levelDataFileContents componentsSeparatedByString:@"\n"];
		leftMapImageName = [levelDataArray objectAtIndex:0];
		rightMapImageName = [levelDataArray objectAtIndex:1];
		leftPiecesTextFile = [levelDataArray objectAtIndex:2];
		rightPiecesTextFile = [levelDataArray objectAtIndex:3];
		numPieces = [[levelDataArray objectAtIndex:4] intValue];
		nextLevelData = [levelDataArray objectAtIndex:5];
		NSLog(@"next level data is: %@", nextLevelData);
		if ([nextLevelData isEqualToString:@"null"]) {
			NSLog(@"islastlevel");
			isLastLevel = YES;
		}
		else {
			isLastLevel = NO;
			
		}

		
		//CREATE BOARDS
		leftMapBoard = [[mapBoard alloc] initWithImage:[UIImage imageNamed:leftMapImageName]];
		[leftMapBoard setFrame:CGRectMake(LEFTBOARDACTIVE_X, BOARD_Y, BOARDWIDTH, BOARDHEIGHT)];
		[self.view addSubview:leftMapBoard];
		
		rightMapBoard = [[mapBoard alloc] initWithImage:[UIImage imageNamed:rightMapImageName]];
		[rightMapBoard setFrame:CGRectMake(RIGHTBOARDACTIVE_X, BOARD_Y, BOARDWIDTH, BOARDHEIGHT)];
		[self.view addSubview:rightMapBoard];
		
		leftPieceBoard = [[pieceBoard alloc] initWithImage:[UIImage imageNamed:@"piece-board.png"]];
		[leftPieceBoard setFrame:CGRectMake(LEFTBOARDACTIVE_X-OFFBOARDX, BOARD_Y, BOARDWIDTH, BOARDHEIGHT)];
		[self.view addSubview:leftPieceBoard];
		
		rightPieceBoard = [[pieceBoard alloc] initWithImage:[UIImage imageNamed:@"piece-board.png"]];
		[rightPieceBoard setFrame:CGRectMake(RIGHTBOARDACTIVE_X+OFFBOARDX, BOARD_Y, BOARDWIDTH, BOARDHEIGHT)];
		[self.view addSubview:rightPieceBoard];

				
		//PARSING LEFT PIECES TEXT FILE
		NSString *filePath = [[NSBundle mainBundle] pathForResource:leftPiecesTextFile ofType:@"txt"];
		NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
		NSLog(@"printing file contents:");
		NSLog(@"%@", fileContents);
		
		//array of lines e.g.: peg01.png 783 123
		NSArray *piecesTextArray = [fileContents componentsSeparatedByString:@"\n"];
		//int piecesCount = [piecesTextArray count];
		//NSLog(@"sizeof array: %d",piecesCount);
		
		//array of piece .png names
		NSString *leftPieceNames[numPieces];
		
		//array of piece locations
		int leftPiecesFinalLocs[(numPieces*2)];
		
		int i = 0;
		for (NSString *pieceTextArray in piecesTextArray) {
			NSArray *pieceProperties = [pieceTextArray componentsSeparatedByString:@" "];
			
			leftPieceNames[i] = (@"%@", [pieceProperties objectAtIndex:0]);
			leftPiecesFinalLocs[(2*i)] = [[pieceProperties objectAtIndex:1] intValue];
			leftPiecesFinalLocs[(2*i+1)] = [[pieceProperties objectAtIndex:2] intValue];
			i++;
			/*
			for (int i = 0; i < leftPiecesCount; i++) {
				leftPieceNames[i] = (@"%@", [leftPiecesArray objectAtIndex:i]);
			}
			*/
		}
				
		/*
		NSString *leftPieceNames[]={
			@"peg01.png",
			@"peg02.png",
			@"peg03.png",
			@"peg04.png",
			@"peg05.png",
			@"peg06.png",
			@"peg07.png",
			@"peg08.png",
			@"peg09.png",
			@"peg10.png",
			@"peg11.png",
			@"peg12.png",
			@"peg13.png",
			@"peg14.png",
			@"peg15.png",
			@"peg16.png",
			@"peg17.png"
		};
		 */
		/*
		int leftPiecesFinalLocs[]={
			702, 142, //peg1
			776, 142, //peg2
			817, 216, //peg3
			770, 293, //peg4
			816, 372, //peg5
			744, 386, //peg6
			776, 469, //peg7
			716, 457, //peg8
			614,455,
			649,374,
			585,352,
			686,304,
			609,279,
			658,219,
			573,201,
			614,146,
			756,227
			
		};
		*/
		
		//PARSING RIGHT PIECES TEXT FILE
		filePath = [[NSBundle mainBundle] pathForResource:rightPiecesTextFile ofType:@"txt"];
		fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
		NSLog(@"printing file contents:");
		NSLog(@"%@", fileContents);
		
		//array of lines e.g.: peg01.png 783 123
		piecesTextArray = [fileContents componentsSeparatedByString:@"\n"];
		
		//array of piece .png names
		NSString *rightPieceNames[numPieces];
		
		//array of piece locations
		int rightPiecesFinalLocs[(numPieces*2)];
		
		i = 0;
		for (NSString *pieceTextArray in piecesTextArray) {
			NSArray *pieceProperties = [pieceTextArray componentsSeparatedByString:@" "];
			
			rightPieceNames[i] = (@"%@", [pieceProperties objectAtIndex:0]);
			rightPiecesFinalLocs[(2*i)] = [[pieceProperties objectAtIndex:1] intValue];
			rightPiecesFinalLocs[(2*i+1)] = [[pieceProperties objectAtIndex:2] intValue];
			i++;
			
		}
		
		/*
		NSString *rightPieceNames[]={
			@"peg01f.png",
			@"peg02f.png",
			@"peg03f.png",
			@"peg04f.png",
			@"peg05f.png",
			@"peg06f.png",
			@"peg07f.png",
			@"peg08f.png",
			@"peg09f.png",
			@"peg10f.png",
			@"peg11f.png",
			@"peg12f.png",
			@"peg13f.png",
			@"peg14f.png",
			@"peg15f.png",
			@"peg16f.png",
			@"peg17f.png"
		};
		 */
		/*
		int rightPiecesFinalLocs[]={
			208,142,
			164,142,
			113,216,
			144,293,
			113,372,
			184,386,
			164,469,
			235,457,
			295,455,
			263,374,
			340,352,
			225,304,
			313,279,
			264,219,
			347,201,
			300,146,
			174,227
		};
		*/
		
		leftPieces = [[NSMutableArray alloc] init];
		for (int i = 0; i < numPieces; i++) {
			int initX;
			int initY;
			if(i < 6){
				initX = LEFTBOARDACTIVE_X-OFFBOARDX+20;
				initY = BOARD_Y+10+(i*110);
			}else if((6 <= i) && (i < 12)){
				initX = LEFTBOARDACTIVE_X-OFFBOARDX+140;
				initY = BOARD_Y+10+((i-6)*110);
			}else {
				initX = LEFTBOARDACTIVE_X-OFFBOARDX+260;
				initY = BOARD_Y+20+((i-12)*120);
			}
			draggable *piece = [[draggable alloc] initWithImage:[UIImage imageNamed:leftPieceNames[i]] withInitX:initX withInitY:initY withFinalX:leftPiecesFinalLocs[i*2] withFinalY:leftPiecesFinalLocs[i*2+1]];
			[piece setFrame:CGRectOffset([piece frame], initX, initY)];
			[piece setUserInteractionEnabled:YES];
			[self.view addSubview:piece];
			piece.containingview = self;
			[leftPieces addObject:piece];
		}
		
		rightPieces = [[NSMutableArray alloc] init];
		for (int i = 0; i < numPieces; i++) {
			int initX;
			int initY;
			if(i < 6){
				initX = RIGHTBOARDACTIVE_X+OFFBOARDX+20;
				initY = BOARD_Y+10+(i*110);
			}else if((6 <= i) && (i < 12)){
				initX = RIGHTBOARDACTIVE_X+OFFBOARDX+140;
				initY = BOARD_Y+10+((i-6)*110);
			}else{
				initX = RIGHTBOARDACTIVE_X+OFFBOARDX+260;
				initY = BOARD_Y+10+((i-12)*120);
			}
			draggable *piece = [[draggable alloc] initWithImage:[UIImage imageNamed:rightPieceNames[i]] withInitX:initX withInitY:initY withFinalX:rightPiecesFinalLocs[i*2] withFinalY:rightPiecesFinalLocs[i*2+1]];
			[piece setFrame:CGRectOffset([piece frame], initX, initY)];
			[piece setUserInteractionEnabled:YES];
			[self.view addSubview:piece];
			piece.containingview = self;
			[rightPieces addObject:piece];
		}
		
		 
		CGRect overlayRect = CGRectMake(0,0,1024,748);
		overlayImage = [[UIImageView alloc] initWithFrame:overlayRect];
		[overlayImage setImage:[UIImage imageNamed:@"overlay-image.png"]];
		overlayImage.alpha = 0.85;
		[self.view addSubview:overlayImage];
		[overlayImage release];
		
		
		[self.view sendSubviewToBack:overlayImage];
		[self.view sendSubviewToBack:leftMapBoard];
		[self.view sendSubviewToBack:rightMapBoard];
		[self.view sendSubviewToBack:leftPieceBoard];
		[self.view sendSubviewToBack:rightPieceBoard];
		
		numBlocksLeft = [leftPieces count];
		numBlocksRight = [rightPieces count];
		numBlocks = [leftPieces count] + [rightPieces count];
		//numBlocks = 4;
		
		timerValid = YES;
		//timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countSeconds) userInfo:nil repeats:YES];
		leftTime = MAXPIECEPOINTS;
		rightTime = MAXPIECEPOINTS;
		timerLabel.text = [NSString stringWithFormat:@"%i",leftTime];
		timerLabel.hidden = YES;
		//rightTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countSeconds) userInfo:nil repeats:YES];
		
		[self showOverlay];
    }
    return self;
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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

- (void)hideOverlay {
	overlayImage.alpha=0;
	pausedLabel.hidden=YES; 
	pressButtonsLabel.hidden=YES;
	blurbLabel.hidden=YES;
	leftArrow.hidden=YES;
	rightArrow.hidden=YES;
}

-(void)showOverlay {
	NSLog(@"GAMESTATE: %i", gamestate);
	if (gamestate==COMPLETE) {
		blurbLabel.hidden=YES;
		leftArrow.hidden=YES;
		rightArrow.hidden=YES;
		overlayImage.alpha=0.3;
		if (isLastLevel) {
			[self makeScoreButton];
		}
		else {
			[self makeNextLevelButton];
		}

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

-(IBAction)leftSideTouchDown:(UIButton *)leftButton{
	if(gamestate==NONEACTIVE){
		gamestate = RIGHTACTIVE;
	}
	[self hideOverlay];
	rightButton.hidden = YES;
	
	timerLabel.text = [NSString stringWithFormat:@"%i",rightTime];
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countSeconds) userInfo:nil repeats:YES];
	timerLabel.hidden = NO;
	
	[UIView beginAnimations:@"animateImageOff" context:NULL]; // Begin animation
	[leftMapBoard setFrame:CGRectOffset([leftMapBoard frame], 0-OFFBOARDX, 0)];
	[rightMapBoard setFrame:CGRectOffset([rightMapBoard frame], 0-ACROSSBOARD_X, 0)];
	[rightPieceBoard setFrame:CGRectOffset([rightPieceBoard frame], 0-OFFBOARDX, 0)];
	
	if (rightSideCompleted && (!leftSideCompleted)) {
		rightSideCompletedLabel.hidden=NO;
	}
	
	draggable *piece = [[draggable alloc] init];
	for(piece in leftPieces){
		[piece setFrame:CGRectOffset([piece frame], -OFFBOARDX, 0)];
	}
	for(piece in rightPieces){
		if(piece.canMove == YES){
			[piece setFrame:CGRectOffset([piece frame], -OFFBOARDX, 0)];
		}else {
			[piece setFrame:CGRectOffset([piece frame], -ACROSSBOARD_X, 0)];
		}
	}
	[piece release];
	[UIView commitAnimations]; // End animations
}
-(IBAction)leftSideTouchUp:(UIButton *)leftButton{
	[self leftToCenter];
	rightSideCompletedLabel.hidden=YES;
}

-(void)leftToCenter{
	if (gamestate==RIGHTACTIVE) {
		gamestate=NONEACTIVE;
	}
	[self showOverlay];
	rightButton.hidden = NO;
	
	[timer invalidate];
	timerLabel.hidden = YES;
	
	
	[UIView beginAnimations:@"animateImageOff" context:NULL]; // Begin animation
	[leftMapBoard setFrame:CGRectOffset([leftMapBoard frame], OFFBOARDX, 0)];
	[rightMapBoard setFrame:CGRectOffset([rightMapBoard frame], ACROSSBOARD_X, 0)];
	[rightPieceBoard setFrame:CGRectOffset([rightPieceBoard frame], OFFBOARDX, 0)];
	draggable *piece = [[draggable alloc] init];
	for(piece in leftPieces){
		[piece setFrame:CGRectOffset([piece frame], OFFBOARDX, 0)];
	}
	for(piece in rightPieces){
		if(piece.canMove == NO){
			[piece setFrame:CGRectOffset([piece frame], ACROSSBOARD_X, 0)];
		}else {
			piece.active = NO;
			//[piece setFrame:CGRectOffset([piece frame], OFFBOARDX, 0)];
			[piece setFrame:CGRectMake(piece.initLocX, piece.initLocY, piece.frame.size.width, piece.frame.size.height)];
			
		}
	}
	[piece release];
	[UIView commitAnimations]; // End animations
}

-(IBAction)rightSideTouchDown:(UIButton *)rightButton{
	if(gamestate==NONEACTIVE){
		gamestate = LEFTACTIVE;
	}
	[self hideOverlay];
	leftButton.hidden = YES;

	timerLabel.text = [NSString stringWithFormat:@"%i",leftTime];
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countSeconds) userInfo:nil repeats:YES];
	timerLabel.hidden = NO;

	[UIView beginAnimations:@"animateImageOff" context:NULL]; // Begin animation
	[leftMapBoard setFrame:CGRectOffset([leftMapBoard frame], ACROSSBOARD_X, 0)];
	[rightMapBoard setFrame:CGRectOffset([rightMapBoard frame], OFFBOARDX, 0)];
	[leftPieceBoard setFrame:CGRectOffset([leftPieceBoard frame], OFFBOARDX, 0)];
	
	if (leftSideCompleted && (!rightSideCompleted)) {
		leftSideCompletedLabel.hidden=NO;
	}
	
	draggable *piece = [[draggable alloc] init];
	for(piece in rightPieces){
		[piece setFrame:CGRectOffset([piece frame], OFFBOARDX, 0)];
	}
	for(piece in leftPieces){
		if(piece.canMove == YES){
			[piece setFrame:CGRectOffset([piece frame], OFFBOARDX, 0)];
		}else {
			[piece setFrame:CGRectOffset([piece frame], ACROSSBOARD_X, 0)];
		}
	}
	[piece release];
	[UIView commitAnimations]; // End animations
}
-(IBAction)rightSideTouchUp:(UIButton *)rightButton{
	[self rightToCenter];
	leftSideCompletedLabel.hidden = YES;
}

-(void)rightToCenter{
	if(gamestate == LEFTACTIVE){
		gamestate = NONEACTIVE;
	}
	[self showOverlay];
	leftButton.hidden = NO;
	
	[timer invalidate];
	timerLabel.hidden = YES;
	
	[UIView beginAnimations:@"animateImageOff" context:NULL]; // Begin animation
	[leftMapBoard setFrame:CGRectOffset([leftMapBoard frame], -ACROSSBOARD_X, 0)];
	[rightMapBoard setFrame:CGRectOffset([rightMapBoard frame], -OFFBOARDX, 0)];
	[leftPieceBoard setFrame:CGRectOffset([leftPieceBoard frame], -OFFBOARDX, 0)];
	draggable *piece = [[draggable alloc] init];
	for(piece in rightPieces){
		[piece setFrame:CGRectOffset([piece frame], -OFFBOARDX, 0)];
	}
	for(piece in leftPieces){
		if(piece.canMove == NO){
			[piece setFrame:CGRectOffset([piece frame], -ACROSSBOARD_X, 0)];
		}else {
			piece.active = NO;
			//[piece setFrame:CGRectOffset([piece frame], -OFFBOARDX, 0)];
			[piece setFrame:CGRectMake(piece.initLocX, piece.initLocY, piece.frame.size.width, piece.frame.size.height)];
			
		}
	}
	[piece release];
	[UIView commitAnimations]; // End animations
}

-(IBAction)backButtonPressed:(UIButton *)backButton {
	if((gamestate==NONEACTIVE) || (gamestate==COMPLETE)){
		quitAlert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to quit?" message:nil
												   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		[quitAlert show];
		[quitAlert release];
	}
	//[self.view removeFromSuperview];
}

- (void)alertView : (UIAlertView *)alertView clickedButtonAtIndex : (NSInteger)buttonIndex{	
	if(alertView == quitAlert){
		if(buttonIndex == 0){
			NSLog(@"no button was pressed\n");
			/*
			if (gamestate==LEFTACTIVE) {
				[self leftToCenter];
			}else if (gamestate==RIGHTACTIVE) {
				[self rightToCenter];
			}
			 */
		}
		else{
			NSLog(@"yes button was pressed\n");
			[self.view removeFromSuperview];
		}
	}else if (alertView==infoAlert) {
	}
}

-(IBAction)infoButtonPressed:(UIButton *)infoButton {
	if ((gamestate==NONEACTIVE)||(gamestate==COMPLETE)) {
		
		infoAlert = [[UIAlertView alloc] initWithTitle:@"Pathways Information"
											message:@"Pathways is a puzzle game based on the Purdue Pegboard Test meant to help train the visual and motor skills of people who have suffered damage to the visual or motor cortex. Pathways is played with both hands in order to facilitate recovery of fine motor function. Pathways was created by UC Berkeley Game Lab" 
											  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[infoAlert show];
		[infoAlert release];
	}
}


-(void)piecePlacedAction:(draggable *)piece{
	piece.alpha = 0.25;
	piece.canMove = NO;
	piece.active = NO;
	if(gamestate == LEFTACTIVE){
		leftScore = (leftScore + leftTime);
		score = (score+leftTime);
		leftTime = MAXPIECEPOINTS+1;
		numBlocksLeft--;
		if(numBlocksLeft==0){
			leftSideCompleted = YES;
			leftSideCompletedLabel.hidden=NO;
		}
	} else if (gamestate == RIGHTACTIVE) {
		rightScore = (rightScore + rightTime);
		score = (score+rightTime);
		rightTime = MAXPIECEPOINTS+1;
		numBlocksRight--;
		if(numBlocksRight==0){
			rightSideCompleted = YES;
			rightSideCompletedLabel.hidden=NO;
		}
	}
	scoreLabel.text = [NSString stringWithFormat:@" SCORE: %i",score];
	numBlocks--;
	
	
	if(numBlocks==0){
		gamestate = COMPLETE;
		[self completedAction];
	}
}

-(void)pieceMisplacedAction:(draggable *)piece{
	[UIView beginAnimations:@"animateImageOff" context:NULL]; 
	if(gamestate == LEFTACTIVE){
		[piece setFrame:CGRectMake(piece.initLocX+OFFBOARDX, piece.initLocY, piece.frame.size.width, piece.frame.size.height)];
	}
	else if (gamestate == RIGHTACTIVE){
		[piece setFrame:CGRectMake(piece.initLocX-OFFBOARDX, piece.initLocY, piece.frame.size.width, piece.frame.size.height)];
	}
	else if (gamestate == NONEACTIVE){
		[piece setFrame:CGRectMake(piece.initLocX, piece.initLocY, piece.frame.size.width, piece.frame.size.height)];
	}
	[UIView commitAnimations];
}

-(void)completedAction {
	gamestate = COMPLETE;
	NSLog(@"GAMESTATE: %i", gamestate);
	pausedLabel.text = [NSString stringWithFormat:@"GREAT JOB!"];
	pressButtonsLabel.text = [NSString stringWithFormat:@"Your final score is: %i", score];
	[self.view bringSubviewToFront:pausedLabel];
	[self.view bringSubviewToFront:pressButtonsLabel];
	if(isLastLevel){
		[self loadScores];
		[self updateScores];
		[self saveScores];
	}	
}

-(void)makeScoreButton{
	UIButton *scoreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[scoreButton addTarget:self action:@selector(scoresButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[scoreButton setTitle:@"View Scores" forState:UIControlStateNormal];
	scoreButton.frame = CGRectMake(459.0, 437.0, 114.0, 37.0);
	[self.view addSubview:scoreButton];
}

-(void)scoresButtonPressed{
	scoreViewController *aViewController = [[scoreViewController alloc] initWithNibName:@"scoreViewController" bundle:[NSBundle mainBundle]];
	self.aScoreViewController = aViewController;
	[aViewController release];
	UIView *ScoresView = [aScoreViewController view];
	[self.view addSubview:ScoresView];	
}	

-(void)makeNextLevelButton{
	UIButton *nextLevelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[nextLevelButton addTarget:self action:@selector(nextLevelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[nextLevelButton setTitle:@"Next Level" forState:UIControlStateNormal];
	nextLevelButton.frame = CGRectMake(459.0, 437.0, 114.0, 37.0);
	[self.view addSubview:nextLevelButton];
}

-(void)nextLevelButtonPressed{
	NSLog(@"trying to go to newlevel now");
	isLastLevel = YES;
	[self.view removeFromSuperview];
	NSLog(@"should go to level 2");
	//[[self parentViewController] makeLevelWithLevelData:nextLevelData withLeftScore:leftScore withRightScore:rightScore withScore:score];


	/*
	LevelViewController *aViewController = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:[NSBundle mainBundle] withLevelData:nextLevelData
																		  withLeftScore:leftScore withRightScore:rightScore withScore:score];
	NSLog(@"here 1");
	self.nextLevelViewController = aViewController;
	NSLog(@"here 2");
	[aViewController release];
	NSLog(@"here 3");
	UIView *nextLevelView = [nextLevelViewController view];
	NSLog(@"here 4");
	[self.view addSubview:nextLevelView];	
	 */
}	

//score handling methods
-(void)loadScores{
	NSLog(@"loading scores");
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	scoreArray = nil;
	scoreArray = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"scores"]];
#ifdef RESET_DEFAULTS
	[scores removeAllObjects];
#endif
	if ([scoreArray count] == 0) {		
	}
#ifdef RESET_DEFAULTS
	[self saveScores];
#endif
}

-(void)updateScores{
	//get current date&time
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"MMM dd, yyyy HH:mm"];
	NSDate *now = [[NSDate alloc] init];
	NSString *dateString = [format stringFromDate:now];
	NSLog(@"date: %@", dateString);
	
	NSLog(@"updating scores");
	[scoreArray insertObject:[NSArray arrayWithObjects:
							  now,
							  [NSNumber numberWithInt:leftScore], 
							  [NSNumber numberWithInt:rightScore], 
							  [NSNumber numberWithInt:score], 
							  nil] 
					 atIndex:0];
}

-(void)saveScores{
	NSLog(@"saving scores");
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:scoreArray forKey:@"scores"];
}


- (void)dealloc {
	[leftPieces dealloc];
	[leftMapBoard dealloc];
	[rightMapBoard dealloc];
	[leftPieceBoard dealloc];
	[rightPieceBoard dealloc];
	[timer dealloc];
    [super dealloc];
}


@end
