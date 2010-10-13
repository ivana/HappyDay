//
//  Happy_DayAppDelegate.h
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/10/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Happy_DayAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
  UIWindow * window;
  UITabBarController * tabBarController;
}
@property (nonatomic, retain) IBOutlet UIWindow * window;
@property (nonatomic, retain) IBOutlet UITabBarController * tabBarController;

@end

