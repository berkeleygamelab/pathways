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

@synthesize playerLabel;
@synthesize graphViewButton;
@synthesize graphImageView;
@synthesize currPlayerName;
@synthesize LHDataString, RHDataString, TotalDataString;
@synthesize scoreTableView;

int viewtype;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCurrentScore:(scoreObject *)currScore{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		currPlayerName = currScore.playerName;
		NSLog(@"init-ing score screen setting player to %@", currPlayerName);
		LHDataString = [NSMutableString stringWithFormat:@""];
		RHDataString = [NSMutableString stringWithFormat:@""];
		TotalDataString = [NSMutableString stringWithFormat:@""];


	}
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [playerScoreArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	ScoreTableCell *cell = (ScoreTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	if (cell == nil) {
		
		cell = [[[ScoreTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	NSMutableArray *currScoreField = [playerScoreArray objectAtIndex:indexPath.row];
	
	NSDate *currScoreDate = [currScoreField objectAtIndex:1];
	int *currLeftScore = (int *)[[currScoreField objectAtIndex:2] intValue];
	int *currRightScore = (int *)[[currScoreField objectAtIndex:3] intValue];
	int *currTotalScore = (int *)[[currScoreField objectAtIndex:4] intValue];
	
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"MMM dd, yyyy HH:mm"];
	NSString *dateString = [format stringFromDate:currScoreDate];
	
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 180.0, tableView.rowHeight)] autorelease];
	label.text = dateString;
	label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
	[cell addColumn:190];
	[cell.contentView addSubview:label];
	
	label = [[[UILabel alloc] initWithFrame:CGRectMake(200.0, 0.0, 120.0, tableView.rowHeight)] autorelease];
	label.text = [NSString stringWithFormat:@"%i", currLeftScore];
	label.textAlignment = UITextAlignmentCenter;
	label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
	[cell addColumn:330];
	[cell.contentView addSubview:label];
	
	label = [[[UILabel alloc] initWithFrame:CGRectMake(340.0, 0.0, 120.0, tableView.rowHeight)] autorelease];
	label.text = [NSString stringWithFormat:@"%i", currRightScore];
	label.textAlignment = UITextAlignmentCenter;
	label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
	[cell addColumn:470];
	[cell.contentView addSubview:label];
	
	label = [[[UILabel alloc] initWithFrame:CGRectMake(480.0, 0.0, 120.0, tableView.rowHeight)] autorelease];
	label.text = [NSString stringWithFormat:@"%i", currTotalScore];
	label.textAlignment = UITextAlignmentCenter;
	label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
	[cell.contentView addSubview:label];
	
	return cell;
}	

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	scoreTableView.allowsSelection = NO;
	playerLabel.text = currPlayerName;
	[self loadScores];
	[self getPlayerScores];
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
	}
#ifdef RESET_DEFAULTS
	[self saveScores];
#endif
}
	 
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

-(void)getPlayerScores{
	NSLog(@"displaying scores");
	playerScoreArray = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < [scoreArray count]; i++) {
		
		NSMutableArray *currScoreField = [scoreArray objectAtIndex:i];
		NSString *playerName = [currScoreField objectAtIndex:0];
				
		if([playerName isEqualToString:currPlayerName]){
			[playerScoreArray addObject:currScoreField];
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


-(void)createDataLists{
	for (int i =0; i < [playerScoreArray count]; i++) {
		NSMutableArray *currScoreField = [playerScoreArray objectAtIndex:i];
		int currLeftScore = (int)[[currScoreField objectAtIndex:2] intValue];
		int currRightScore = (int)[[currScoreField objectAtIndex:3] intValue];
		int currTotalScore = (int)[[currScoreField objectAtIndex:4] intValue];
		[self addToDataList:LHDataString dataPoint:currLeftScore];
		[self addToDataList:RHDataString dataPoint:currRightScore];
		[self addToDataList:TotalDataString dataPoint:currTotalScore];
	}
}

-(void) showGraph{
	NSLog(@"trying to get image from URL");
	[self createDataLists];
	NSString *preDataString = [NSString stringWithFormat:@"http://chart.apis.google.com/chart?chxl=0:|0|500|1000|1500|2000&chxr=1,0,0&chxt=y,r&chs=648x462&cht=lc&chco=FF0000,0000FF,FF9900&chd=t:"];
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
