    //
//  highScoreViewController.m
//  Pathways
//
//  Created by Berkeley Game Lab on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "highScoreViewController.h"


@implementation highScoreViewController

@synthesize scoreArray, topScores;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadScores];
	[self showTopScores];
}


-(void)loadScores{
	NSLog(@"loading scores");
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	scoreArray = nil;
	scoreArray = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"scores"]];
}


-(void)showTopScores{
	[self findTopScores];
	[self showScores];
}

-(void)findTopScores{
	
	
}

-(void)showScores{
	NSLog(@"displaying scores");
	
	for (int i = 0; i < [scoreArray count]; i++) {
		NSLog(@"in SCORES 1");
		NSMutableArray *currScoreField = [scoreArray objectAtIndex:i];
		NSLog(@"in SCORES 2");

		NSString *playerName = [currScoreField objectAtIndex:0];
		NSDate *currScoreDate = [currScoreField objectAtIndex:1];
		int *currLeftScore = (int *)[[currScoreField objectAtIndex:2] intValue];
		int *currRightScore = (int *)[[currScoreField objectAtIndex:3] intValue];
		int *currTotalScore = (int *)[[currScoreField objectAtIndex:4] intValue];
		UIColor *scoreColor = [UIColor whiteColor];
		NSLog(@"in SCORES 3");

		
		 UILabel *playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 140+20*i, 200, 20)];
		 playerNameLabel.text = [NSString stringWithFormat:@"%@", playerName];
		 playerNameLabel.backgroundColor = [UIColor clearColor];
		 playerNameLabel.textColor = scoreColor;
		 playerNameLabel.textAlignment = UITextAlignmentLeft;		
		 
			NSDateFormatter *format = [[NSDateFormatter alloc] init];
			[format setDateFormat:@"MMM dd, yyyy HH:mm"];
			NSString *dateString = [format stringFromDate:currScoreDate];
			NSLog(@"inSCORES: date: %@", dateString);
			
			UILabel *dateAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 140+20*i, 200, 20)];
			dateAndTimeLabel.text = [NSString stringWithFormat:@"%@", dateString];
			dateAndTimeLabel.backgroundColor = [UIColor clearColor];
			dateAndTimeLabel.textColor = scoreColor;
			dateAndTimeLabel.textAlignment = UITextAlignmentLeft;
			
			UILabel *leftScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(417, 140+20*i, 130, 20)];
			leftScoreLabel.text = [NSString stringWithFormat:@"%i", currLeftScore];
			leftScoreLabel.backgroundColor = [UIColor clearColor];
			leftScoreLabel.textColor = scoreColor;
			leftScoreLabel.textAlignment = UITextAlignmentCenter;
			
			UILabel *rightScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(560, 140+20*i, 130, 20)];
			rightScoreLabel.text = [NSString stringWithFormat:@"%i", currRightScore];
			rightScoreLabel.backgroundColor = [UIColor clearColor];
			rightScoreLabel.textColor = scoreColor;
			rightScoreLabel.textAlignment = UITextAlignmentCenter;
			
			UILabel *totalScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(703, 140+20*i, 130, 20)];
			totalScoreLabel.text = [NSString stringWithFormat:@"%i", currTotalScore];
			totalScoreLabel.backgroundColor = [UIColor clearColor];
			totalScoreLabel.textColor = scoreColor;
			totalScoreLabel.textAlignment = UITextAlignmentCenter;
			
			[self.view addSubview:playerNameLabel];
			[self.view addSubview:dateAndTimeLabel];
			[self.view addSubview:leftScoreLabel];
			[self.view addSubview:rightScoreLabel];
			[self.view addSubview:totalScoreLabel];
			
		
	}
	
	
}

-(IBAction)doneButtonPressed:(UIButton *)doneButton {
	gameAppDelegate *appDelegate = (gameAppDelegate *)[[UIApplication sharedApplication] delegate];

	
	[self.view removeFromSuperview];
	[appDelegate showMainScreen];
	
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


- (void)dealloc {
    [super dealloc];
}


@end
