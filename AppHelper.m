//
//  AppHelper.m
//  Happy_Day
//
//  Created by Ivana Vasilj on 11/9/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "AppHelper.h"


@implementation AppHelper

+(NSString *) dataFilePath
{ 
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString * documentsDirectory = [paths objectAtIndex:0]; 
  
  return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

@end
