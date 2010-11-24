//
//  HappyTodayViewController.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "HappyTodayViewController.h"
#import "HappyDay.h"
#import "AppHelper.h"

#define kYesTag 1


@implementation HappyTodayViewController

@synthesize happyToday, happyClicked;

#pragma mark -
#pragma mark Action Methods

-(IBAction) happyTodayClicked:(id)sender
{
  UIButton * buttonClicked = (UIButton *) sender;
  NSString * feedbackMessage = [[NSString alloc] init];
  happyClicked = YES;
  
  if (buttonClicked.tag == kYesTag) {
    [happyToday setHappy:YES];
    feedbackMessage = @"Good to hear!";
  } else {
    [happyToday setHappy:NO];
    feedbackMessage = @"Sorry to hear that. After all, tomorrow is another day...";
  }
  
  UIAlertView * feedback = [[UIAlertView alloc] initWithTitle:nil message:feedbackMessage delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
  [feedback show];
  
  [feedback release];
  [feedbackMessage release];
}

#pragma mark -
#pragma mark Overridden / Implemented Methods

-(void) viewDidLoad
{
  happyToday = [[HappyDay alloc] init];
  happyClicked = NO;
  
  UIApplication * app = [UIApplication sharedApplication]; 
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:app];
  
  [super viewDidLoad];
}


-(void) applicationWillTerminate:(NSNotification *)notification
{
  if(happyClicked == YES) {
    
    NSString * filePath = [AppHelper dataFilePath];
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSMutableDictionary * happiness;
    NSString * happyString = [[NSString alloc] initWithFormat:@"%d", [happyToday happy]];
    NSString * happyTimeString = [dateFormatter stringFromDate:[NSDate date]];
    
    if ([fileManager fileExistsAtPath:filePath]) {
      happiness = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
      NSLog(@"Initialized from file with content: %@", happiness);    
    } else {
      happiness = [[NSMutableDictionary alloc] init];
      [fileManager createFileAtPath:filePath contents:nil attributes:nil];
      [happiness setValue:happyTimeString forKey:kSince];
      NSLog(@"File created and initialized.");
    }
    
    [happiness setValue:happyString forKey:happyTimeString];
    NSLog(@"Happiness with the newest entry: %@", happiness);
    
    BOOL result = [happiness writeToFile:filePath atomically:YES];
    NSLog(@"Written to file: %d", result);
    
    [fileManager release];
    [happiness release];
    [happyString release];
    [dateFormatter release];
  }
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


-(void) viewDidUnload
{
  self.happyToday = nil;
  [super viewDidUnload];
}


-(void) dealloc
{
  [happyToday release];
  [super dealloc];
}

@end
