    //
//  scoreViewController.m
//  Pathways
//
//  Created by Berkeley Game Lab on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "scoreViewController.h"
#define GRAPHVIEW 0
#define LISTVIEW 1

@implementation scoreViewController

//@synthesize score1Label, score2Label, score3Label, score4Label, score5Label;
@synthesize scoreScrollView;
@synthesize playerLabel;
@synthesize graphViewButton;
@synthesize graphImageView;
@synthesize currPlayerName;
@synthesize LHDataString, RHDataString, TotalDataString;

int viewtype;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCurrentScore:(scoreObject *)currScore{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		//totalScore = newScore;
		currPlayerName = currScore.playerName;
		NSLog(@"init-ing score screen setting player to %@", currPlayerName);
		LHDataString = [NSMutableString stringWithFormat:@""];
		RHDataString = [NSMutableString stringWithFormat:@""];
		TotalDataString = [NSMutableString stringWithFormat:@""];


	}
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	playerLabel.text = currPlayerName;
	//NSLog(@"%i", totalScore);
	[self loadScores];
	[self showScores];
	[self showGraph];
	viewtype = 0;
	[graphViewButton addTarget:self action:@selector(graphViewButtonPressed) forControlEvents:UIControlEventTouchUpInside];

	

}

-(void)loadScores{
	NSLog(@"loading scores");
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	scoreArray = nil;
	scoreArray = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"scores"]];
#ifdef RESET_DEFAULTS
	[scores removeAllObjects];
#endif
	if ([scoreArray count] == 0) {
		//[scoreArray addObject:[NSArray arrayWithObjects:@"0001", [NSNumber numberWithInt:25],nil]];
		
	}
#ifdef RESET_DEFAULTS
	[self saveScores];
#endif
}

/*
-(void)updateScores{
	NSLog(@"updating scores");
	[scoreArray insertObject:[NSArray arrayWithObjects:@"player", [NSNumber numberWithInt:totalScore],nil] atIndex:[scoreArray count]];
}

-(void)saveScores{
	NSLog(@"saving scores");
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:scoreArray forKey:@"scores"];
}
 */
	 
-(void)graphViewButtonPressed{
	if (viewtype == 0) {
		viewtype = 1;
		graphImageView.hidden = YES;
		[graphViewButton setTitle:@"View Score Graph" forState:UIControlStateNormal];
	} else if (viewtype == 1) {
		viewtype = 0;
		graphImageView.hidden = NO;
		[graphViewButton setTitle:@"View Scores as List" forState:UIControlStateNormal];
	}
}

-(void)showScores{
	NSLog(@"displaying scores");
	
	int j = 0;
	for (int i = 0; i < [scoreArray count]; i++) {
		
		NSMutableArray *currScoreField = [scoreArray objectAtIndex:i];
		NSString *playerName = [currScoreField objectAtIndex:0];
		NSDate *currScoreDate = [currScoreField objectAtIndex:1];
		int *currLeftScore = (int *)[[currScoreField objectAtIndex:2] intValue];
		int *currRightScore = (int *)[[currScoreField objectAtIndex:3] intValue];
		int *currTotalScore = (int *)[[currScoreField objectAtIndex:4] intValue];
		UIColor *scoreColor;
		
		if(i == 0){
			scoreColor = [UIColor greenColor];
		}else{
			scoreColor = [UIColor whiteColor];
		}
		
		if([playerName isEqualToString:currPlayerName]){
		
			NSDateFormatter *format = [[NSDateFormatter alloc] init];
			[format setDateFormat:@"MMM dd, yyyy HH:mm"];
			NSString *dateString = [format stringFromDate:currScoreDate];
			NSLog(@"inSCORES: date: %@", dateString);
		
			UILabel *dateAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 140+20*j, 200, 20)];
			dateAndTimeLabel.text = [NSString stringWithFormat:@"%@", dateString];
			dateAndTimeLabel.backgroundColor = [UIColor clearColor];
			dateAndTimeLabel.textColor = scoreColor;
			dateAndTimeLabel.textAlignment = UITextAlignmentLeft;
		
			UILabel *leftScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(417, 140+20*j, 130, 20)];
			leftScoreLabel.text = [NSString stringWithFormat:@"%i", currLeftScore];			
			leftScoreLabel.backgroundColor = [UIColor clearColor];
			leftScoreLabel.textColor = scoreColor;
			leftScoreLabel.textAlignment = UITextAlignmentCenter;
			[self addToDataList:LHDataString dataPoint:currLeftScore];
		
			UILabel *rightScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(560, 140+20*j, 130, 20)];
			rightScoreLabel.text = [NSString stringWithFormat:@"%i", currRightScore];
			rightScoreLabel.backgroundColor = [UIColor clearColor];
			rightScoreLabel.textColor = scoreColor;
			rightScoreLabel.textAlignment = UITextAlignmentCenter;
			[self addToDataList:RHDataString dataPoint:currRightScore];
		
			UILabel *totalScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(703, 140+20*j, 130, 20)];
			totalScoreLabel.text = [NSString stringWithFormat:@"%i", currTotalScore];
			totalScoreLabel.backgroundColor = [UIColor clearColor];
			totalScoreLabel.textColor = scoreColor;
			totalScoreLabel.textAlignment = UITextAlignmentCenter;
			[self addToDataList:TotalDataString dataPoint:currTotalScore];
		
			[self.view addSubview:dateAndTimeLabel];
			[self.view addSubview:leftScoreLabel];
			[self.view addSubview:rightScoreLabel];
			[self.view addSubview:totalScoreLabel];
			
			j++;
		}
	}

	
}
		 
-(void) addToDataList:(NSMutableString *)dataSetString dataPoint:(int)scoreData{
	int scaledScore = scoreData / 20;
	if ([dataSetString isEqualToString:@""]) {
		[dataSetString appendFormat:@"%i", scaledScore];
	} else {
		NSString *scaledScoreString = [NSString stringWithFormat:@"%i,", scaledScore];
		[dataSetString insertString:scaledScoreString atIndex:0];
	}

}

-(void) showGraph{
	NSLog(@"trying to get image from URL");

	NSString *preDataString = [NSString stringWithFormat:@"http://chart.apis.google.com/chart?chxl=0:|0|500|1000|1500|2000&chxr=1,0,0&chxt=y,r&chs=648x462&cht=lc&chco=FF0000,0000FF,FF9900&chd=t:"];
	//LHDataString = [NSString stringWithFormat:@"63.934"];
	//RHDataString = [NSString stringWithFormat:@"65.574"];
	//TotalDataString = [NSString stringWithFormat:@"49.18"];
	NSString *postDataString = [NSString stringWithFormat:@"&chdl=Left+Hand|Right+Hand|Total+Score&chls=2|2|3&chma=15,17,15,15|68,44"];
	
	NSString *graphURLString = [NSString stringWithFormat:@"%@%@|%@|%@%@", preDataString, LHDataString, RHDataString, TotalDataString, postDataString];
	
	graphURLString = [graphURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
	NSURL *graphURL = [NSURL URLWithString:graphURLString];
	NSData *graphData = [NSData dataWithContentsOfURL:graphURL];
	UIImage *graphImage = [UIImage imageWithData:graphData];
	graphImageView = [[UIImageView alloc] initWithImage:graphImage];
	[graphImageView setFrame:CGRectMake(37, 99, 950, 550)];
	[self.view addSubview:graphImageView];
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


-(IBAction)doneButtonPressed:(UIButton *)doneButton {
	gameAppDelegate *appDelegate = (gameAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self.view removeFromSuperview];
	[appDelegate showMainScreen];


}

- (void)dealloc {
    [super dealloc];
}


@end
