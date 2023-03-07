//
//  key.m
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "key.h"

@implementation key
@synthesize name;

-(key*) init: (NSString*) inName  {
	[super init];
	name = inName;
	return self;
}
@end
