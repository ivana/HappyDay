//
//  Happy_DayAppDelegate.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/10/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "Happy_DayAppDelegate.h"

@implementation Happy_DayAppDelegate


@synthesize window;

@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  // Override point for customization after application launch.
  // Add the tab bar controller's current view as a subview of the window
  [window addSubview:tabBarController.view];
  [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

  // Save data if appropriate.
}

- (void)dealloc {

  [window release];
  [tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

@end

