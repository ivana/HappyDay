//
//  StatsViewController.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "StatsViewController.h"


@implementation StatsViewController

@synthesize infoLabel, happyPercentageButton, statsPeriodPicker, statsPeriodData;

-(IBAction) percentageClicked:(id)sender
{
  NSString * buttonTitle = [sender titleForState:UIControlStateNormal];
  NSInteger happyPercentage = [[[buttonTitle componentsSeparatedByString:@"%"] objectAtIndex:0] integerValue];
  
  NSString * happyDescTitle = [[NSString alloc] initWithFormat:@"%d%% happy", happyPercentage];
  NSString * happyDescMessage = [[NSString alloc] init];
  
  if (happyPercentage >= 80) {
    happyDescMessage = @"Congrats! You're a happy person!";
  } else if (happyPercentage < 80 && happyPercentage > 50) {
    happyDescMessage = @"Mostly happy. Still, there's a lot for you to be done.";
  } else if (happyPercentage == 50) {
    happyDescMessage = @"Even Steven. Cross to the bright side already!";
  } else { // happyPercentage < 50
    happyDescMessage = @"Oh, dear. Seems like your days have been gloomy and blue :( Now do something about it!";
  }
    
  UIAlertView * happyDesc = [[UIAlertView alloc] initWithTitle:happyDescTitle message:happyDescMessage delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
  [happyDesc show];
  
  [happyDesc release];
  [happyDescMessage release];
  [happyDescTitle release];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void) viewDidLoad 
{
  self.statsPeriodData = [[NSArray alloc] initWithObjects:@"from the first day", @"1 week back", @"1 month back", @"3 months back", @"6 months back", @"1 year back", nil];
  [self.statsPeriodPicker selectRow:1 inComponent:0 animated:NO];
  
  [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload
{
  self.infoLabel = nil;
  self.happyPercentageButton = nil;
  self.statsPeriodPicker = nil;
  self.statsPeriodData = nil;
  [super viewDidUnload];
}


- (void) dealloc
{
  [infoLabel release];
  [happyPercentageButton release];
  [statsPeriodPicker release];
  [statsPeriodData release];
  [super dealloc];
}

#pragma mark - 
#pragma mark Picker Data Source Methods 
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{
  return 1;
} 

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
  return [statsPeriodData count];
} 

#pragma mark Picker Delegate Methods 
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{ 
  return [statsPeriodData objectAtIndex:row];
}

@end
