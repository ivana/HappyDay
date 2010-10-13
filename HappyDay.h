//
//  HappyDay.h
//  HappyDay
//
//  Created by Ivana Vasilj on 9/23/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HappyDay : NSObject
{
  NSDate * happyTime;
  BOOL happy;
}
@property (retain, nonatomic) NSDate * happyTime;
@property BOOL happy;

-(id) initWithTimeAndHappy: (BOOL) happiness;

@end
