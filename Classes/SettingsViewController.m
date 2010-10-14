//
//  SettingsViewController.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize timePicker, hours, minutes;

- (IBAction) promptChanged:(id)sender 
{
  UISwitch * prompt = (UISwitch *) sender;
  
  if (prompt.isOn) [timePicker setUserInteractionEnabled:YES];
  else [timePicker setUserInteractionEnabled:NO];
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad 
{
  self.hours = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", nil];
  self.minutes = [[NSArray alloc] initWithObjects:@"00", @"15", @"30", @"45", nil];
  
  [self.timePicker selectRow:20 inComponent:kHourComponent animated:NO];
  [self.timePicker selectRow:2 inComponent:kMinuteComponent animated:NO];

  // [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void) didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload 
{
  self.timePicker = nil;
  self.hours = nil;
  self.minutes = nil;
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void) dealloc 
{
  [timePicker release];
  [hours release];
  [minutes release];
  [super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods 
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{
  return 2;
} 

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
  if (component == kHourComponent) return [self.hours count];
  return [self.minutes count];
} 

#pragma mark Picker Delegate Methods 
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
  if (component == kHourComponent) return [self.hours objectAtIndex:row];
  return [self.minutes objectAtIndex:row];
}

@end
