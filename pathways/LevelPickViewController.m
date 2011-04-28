    //
//  LevelPickViewController.m
//  Pathways
//
//  Created by Rahul Kartikeya Gupta on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelPickViewController.h"


@implementation LevelPickViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

@synthesize levelController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPlayerScore:playerScore{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		score = playerScore;
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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


- (IBAction) loadLevel1: (UIButton *) sender
{
	LevelViewController *aViewController = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:[NSBundle mainBundle] withLevelData:@"level_01_data" withScoreObject:score];
	self.levelController = aViewController;
	[aViewController release];
	[self.navigationController pushViewController:self.levelController animated:NO];
	//[self.view addSubview:Level1View];
	
	
}

- (IBAction) loadLevel2: (UIButton *) sender
{
	LevelViewController *aViewController = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:[NSBundle mainBundle] withLevelData:@"level_02_data" withScoreObject:score];
	self.levelController = aViewController;
	[aViewController release];
	[self.navigationController pushViewController:self.levelController animated:NO];
	//[aViewController release];
	//UIView *Level1View = [aViewController view];
	//[self.view removeFromSuperview];
	//[self.view addSubview:Level1View];
	
	
}


- (IBAction) loadLevel3: (UIButton *) sender
{
	LevelViewController *aViewController = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:[NSBundle mainBundle] withLevelData:@"level_03_data" withScoreObject:score];
	self.levelController = aViewController;
	[aViewController release];
	[self.navigationController pushViewController:self.levelController animated:NO];
	
	
}
- (void)dealloc {
    [super dealloc];
}


@end
