//
//  HappyTodayViewController.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "HappyTodayViewController.h"
#import "HappyDay.h"

#define kFilename @"data.plist"
#define kYesTag 1


@implementation HappyTodayViewController

@synthesize happyToday;


-(NSString *) dataFilePath
{ 
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString * documentsDirectory = [paths objectAtIndex:0]; 
  
  return [documentsDirectory stringByAppendingPathComponent:kFilename];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void) viewDidLoad
{
  happyToday = [[HappyDay alloc] init];
  
  UIApplication * app = [UIApplication sharedApplication]; 
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:app];
  
  [super viewDidLoad];
}


-(IBAction) happyTodayClicked:(id)sender
{
  UIButton * buttonClicked = (UIButton *) sender;
  NSString * feedbackMessage = [[NSString alloc] init];
  
  if (buttonClicked.tag == kYesTag) {
    [happyToday setHappy:YES];
    feedbackMessage = @"Good to hear! See you tomorrow!";
  } else {
    [happyToday setHappy:NO];
    feedbackMessage = @"Sorry to hear that :( Hope things would be better tomorrow...";
  }
  
  UIAlertView * feedback = [[UIAlertView alloc] initWithTitle:nil message:feedbackMessage delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
  [feedback show];
  
  [feedback release];
  [feedbackMessage release];
}


-(void) applicationWillTerminate:(NSNotification *)notification
{
  NSString * filePath = [self dataFilePath];
  NSFileManager * fileManager = [[NSFileManager alloc] init];
  
  NSMutableDictionary * happiness;
  NSString * happyString;
  
  NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  
  if ([fileManager fileExistsAtPath:filePath]) {
    happiness = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    NSLog(@"Initialized from file with content: %@", happiness);
    
  } else {
    happiness = [[NSMutableDictionary alloc] init];
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    
    NSLog(@"File created and initialized.");
  }
  
  happyString = [[NSString alloc] initWithFormat:@"%d", [happyToday happy]];

  [happiness setValue:happyString forKey:[dateFormatter stringFromDate:[NSDate date]]];
  NSLog(@"Happiness with the newest entry: %@", happiness);

  BOOL result = [happiness writeToFile:[self dataFilePath] atomically:YES];
  NSLog(@"Written to file: %d", result);
  
  [fileManager release];
  [happiness release];
  [happyString release];
  [dateFormatter release];
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
