//
//  position.m
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "position.h"


@implementation position

-(position*) init: (NSString*) inName andOffsets: (NSArray*) inOffsets andBase: (NSString*) inBase {
	[super init];
	name = inName;
	offsets = inOffsets;
	base = inBase;
	return self;
}

@end
