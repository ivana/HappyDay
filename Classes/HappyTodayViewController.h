//
//  HappyTodayViewController.h
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HappyDay;


@interface HappyTodayViewController : UIViewController
{
  HappyDay * happyToday;
  BOOL happyClicked;
}
@property (nonatomic, retain) HappyDay * happyToday;
@property BOOL happyClicked;

-(IBAction) happyTodayClicked:(id)sender;

-(void) applicationWillTerminate:(NSNotification *)notification;

@end
