//
//  HappyTodayViewController.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "HappyTodayViewController.h"
#import "AppHelper.h"

#define kYesTag 1


@implementation HappyTodayViewController

#pragma mark -
#pragma mark Action Methods

- (IBAction) happyTodayClicked:(id)sender
{
  UIButton * buttonClicked = (UIButton *) sender;
  NSString * feedbackMessage = [[NSString alloc] init];
  NSString * feedbackTitle = [[NSString alloc] init];
  BOOL happy;
  
  if (buttonClicked.tag == kYesTag) {
    happy = YES;
    feedbackTitle = @"Happy";
    feedbackMessage = @"Good to hear!";
  } else {
    happy = NO;
    feedbackTitle = @"Not Happy";
    feedbackMessage = @"Sorry to hear that. After all, tomorrow is another day...";
  }
  
  UIAlertView * feedback = [[UIAlertView alloc] initWithTitle:feedbackTitle message:feedbackMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [feedback show];
  
  [feedback release];
  [feedbackMessage release];
  [feedbackTitle release];
  
  /* save to plist */
  
  NSString * filePath = [AppHelper dataFilePath];
  NSFileManager * fileManager = [[NSFileManager alloc] init];
  
  NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  
  NSMutableDictionary * happiness;
  NSString * happyString = [[NSString alloc] initWithFormat:@"%d", happy];
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

#pragma mark -
#pragma mark Overridden Methods

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
[super viewDidLoad];
}
*/

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

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)dealloc {
  [super dealloc];
}

@end
