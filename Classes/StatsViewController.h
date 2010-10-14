//
//  StatsViewController.h
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StatsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
  UILabel * infoLabel;
  UIButton * happyPercentageButton;
  
  UIPickerView * statsPeriodPicker;
  NSArray * statsPeriodData;
}
@property (nonatomic, retain) IBOutlet UILabel * infoLabel;
@property (nonatomic, retain) IBOutlet UIButton * happyPercentageButton;

@property (nonatomic, retain) IBOutlet UIPickerView * statsPeriodPicker;
@property (nonatomic, retain) NSArray * statsPeriodData;

@end
