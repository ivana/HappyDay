//
//  HappyTodayViewController.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 10/13/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "HappyTodayViewController.h"

#define kYesTag 1


@implementation HappyTodayViewController

- (IBAction) happyTodayClicked:(id)sender
{
  UIButton * buttonClicked = (UIButton *) sender;
  NSString * feedbackMessage = [[NSString alloc] init];
  
  if (buttonClicked.tag == kYesTag) {
    feedbackMessage = @"Good to hear! See you tomorrow!";
  } else {
    feedbackMessage = @"Sorry to hear that :( Hope things would be better tomorrow...";
  }
  
  UIAlertView * feedback = [[UIAlertView alloc] initWithTitle:nil message:feedbackMessage delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
  [feedback show];
  
  [feedback release];
  [feedbackMessage release];
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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
