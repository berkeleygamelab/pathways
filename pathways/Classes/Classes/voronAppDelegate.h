//
//  voronAppDelegate.h
//  voron
//
//  Created by Rahul Kartikeya Gupta on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class voronViewController;

@interface voronAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    voronViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet voronViewController *viewController;

@end

