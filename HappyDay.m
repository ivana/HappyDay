//
//  HappyDay.m
//  HappyDay
//
//  Created by Ivana Vasilj on 9/23/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "HappyDay.h"


@implementation HappyDay

@synthesize happyTime, happy;

-(id) initWithTimeAndHappy:(BOOL)happiness
{
  self = [super init];
  if (self) {
    happy = happiness;
    happyTime = [NSDate date]; 
  }
  return self;
}

@end
