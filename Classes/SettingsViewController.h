//
//  SettingsViewController.h
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHourComponent 0 
#define kMinuteComponent 1

@interface SettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
  UIPickerView * timePicker;
  NSArray * hours;
  NSArray * minutes;
}
@property (nonatomic, retain) IBOutlet UIPickerView * timePicker;
@property (nonatomic, retain) NSArray * hours, * minutes;

@end
