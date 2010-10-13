//
//  HappyDayTest.m
//  HappyDay
//
//  Created by Ivana Vasilj on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "HappyDay.h"

@interface HappyDayTest : SenTestCase
{
  HappyDay * happyDay;
}
@end


@implementation HappyDayTest

-(void) setUp
{
  happyDay = [[HappyDay alloc] init];
}

-(void) tearDown
{
  [happyDay release];
}

-(void) testInitHappyIsNil
{
  STAssertNil([happyDay happy], @"happy day basic init (happy not set)");
}

-(void) testHappy
{
  [happyDay setHappy:YES];
  STAssertTrue([happyDay happy], @"happy: %d", [happyDay happy]);
}

-(void) testUnhappy
{
  [happyDay setHappy:NO];
  STAssertFalse([happyDay happy], @"happy: %d", [happyDay happy]);
}

-(void) testInitWithHappy
{
  [happyDay initWithTimeAndHappy:YES];
  STAssertNotNil([happyDay happy], @"failed to set happy");
  STAssertTrue([happyDay happy], @"happy: %d", [happyDay happy]);
}

-(void) testInitWithTime
{
  [happyDay initWithTimeAndHappy:YES];
  
  STAssertNotNil([happyDay happyTime], @"happyTime: %@", [happyDay happyTime]);
  
  NSTimeInterval secondsSince = [[happyDay happyTime] timeIntervalSinceNow];
  NSLog(@"seconds since happy time: %f", secondsSince);
  STAssertTrue(secondsSince < 0 && secondsSince > -1, @"seconds since happy time: %f", secondsSince);  
}

@end
