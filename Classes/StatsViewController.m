//
//  StatsViewController.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "StatsViewController.h"
#import "AppHelper.h"

#define kFirstDay 0
#define k1week 1
#define k1month 2
#define k3months 3
#define k6months 4
#define k1year 5


@implementation StatsViewController

@synthesize infoLabel, sinceLabel, happyPercentageButton, statsPeriodPicker, statsPeriodData;


- (IBAction) percentageClicked:(id)sender
{
  NSString * buttonTitle = [sender titleForState:UIControlStateNormal];
  NSInteger happyPercentage = [[[buttonTitle componentsSeparatedByString:@"%"] objectAtIndex:0] integerValue];
  
  NSString * happyDescTitle = [[NSString alloc] initWithFormat:@"%d%% happy", happyPercentage];
  NSString * happyDescMessage = [[NSString alloc] init];
  
  if (happyPercentage >= 80) {
    happyDescMessage = @"Congrats! You're a happy person!";
  } else if (happyPercentage < 80 && happyPercentage > 50) {
    happyDescMessage = @"Mostly happy.";
  } else if (happyPercentage == 50) {
    happyDescMessage = @"Even Steven.";
  } else { // happyPercentage < 50
    happyDescMessage = @"Oh, dear. Seems like your days have been gloomy and blue. Why not do something about it?";
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
  /* init picker */
  self.statsPeriodData = [[NSArray alloc] initWithObjects:@"from the first day", @"1 week back", @"1 month back", @"3 months back", @"6 months back", @"1 year back", nil];
  [self.statsPeriodPicker selectRow:1 inComponent:0 animated:NO]; // 1 week back is default
  
  /* init sinceLabel & happyPercentageButton */
  NSFileManager * fileManager = [[NSFileManager alloc] init];
  NSString * filePath = [AppHelper dataFilePath];
  
  if ([fileManager fileExistsAtPath:filePath]) {
    NSDictionary * happiness = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSString * firstDay = [happiness valueForKey:kSince];
    [sinceLabel setText:[@"Tracking since " stringByAppendingString:firstDay]];
    [happiness release];
  } else {
    [happyPercentageButton setEnabled:NO];
    [happyPercentageButton setTitle:@"Happy Day?" forState:UIControlStateDisabled];

    [infoLabel setText:@"No entries about happiness yet."];
    [sinceLabel setText:@""];
  }

  [fileManager release];
  
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


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
  NSFileManager * fileManager = [[NSFileManager alloc] init];
  NSString * filePath = [AppHelper dataFilePath];
  
  if ([fileManager fileExistsAtPath:filePath]) {
    
    NSMutableDictionary * happiness = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    [happiness removeObjectForKey:kSince];

    NSMutableArray * happyValues;
    NSDate * today = [NSDate date];
    NSDate * referenceDate;

    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    
    if (row == kFirstDay) {
      happyValues = [[NSMutableArray alloc] initWithArray:[happiness allValues]];     

    } else {

      switch (row) {
        case k1week:
          happyValues = [[NSMutableArray alloc] initWithCapacity:7];
          [dateComponents setDay:(-7)];
          break;          
        case k1month:
          happyValues = [[NSMutableArray alloc] initWithCapacity:20];
          [dateComponents setMonth:(-1)];
          break;          
        case k3months:
          happyValues = [[NSMutableArray alloc] initWithCapacity:[happiness count]];
          [dateComponents setMonth:(-3)];
          break;          
        case k6months:
          happyValues = [[NSMutableArray alloc] initWithCapacity:[happiness count]];
          [dateComponents setMonth:(-6)];
          break;          
        case k1year:
          happyValues = [[NSMutableArray alloc] initWithCapacity:[happiness count]];
          [dateComponents setYear:(-1)];
          break;
      }
      
      referenceDate = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
      [self extractValuesfromDictionary:happiness toArray:happyValues since:referenceDate];
    }

    [self displayPercentage:happyValues];
    
    [happiness release];
    [happyValues release];
    [dateComponents release];
  }
  
  [fileManager release];
}

#pragma mark -
#pragma mark Custom Methods

- (void) displayPercentage:(NSMutableArray *)happyValues
{
  float happySum = [[happyValues objectAtIndex:0] floatValue];
  for (int i = 1; i < [happyValues count]; i++) {
    happySum += [[happyValues objectAtIndex:i] floatValue];
  }
  float happyPercentage = happySum / [happyValues count] * 100;
  
  NSString * happyTitle = [[NSString alloc] initWithFormat:@"%.0f%% happy", happyPercentage];  
  [self.happyPercentageButton setTitle:happyTitle forState:UIControlStateNormal];
  [happyTitle release];
}


- (void) extractValuesfromDictionary:(NSMutableDictionary *)happiness toArray:(NSMutableArray *)happyValues since:(NSDate *)referenceDate
{  
//  NSLog(@"reference date: %@", referenceDate);
  NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];

  for (id day in happiness) {
    NSDate * happyDay = [[dateFormatter dateFromString:day] dateByAddingTimeInterval:(60 * 60.0)]; // add 1h to get the correct date (smarter way?)        
    if ([happyDay compare:referenceDate] == NSOrderedDescending) { // happyDay is later in time than referenceDate
      [happyValues addObject:[happiness objectForKey:day]];
    }
  }  
  
  [dateFormatter release];
}

@end
