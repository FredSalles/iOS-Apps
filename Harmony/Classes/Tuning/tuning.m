//
//  tuning.m
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "tuning.h"


@implementation tuning
@synthesize name;
@synthesize notes;
@synthesize description;

-(tuning*) init: (NSString*) inName andDescription: (NSString*) inDescription andNotes: (NSArray*) inNotes {
	[super init];
	name = inName;
	notes = inNotes;
	description = inDescription;
	return self;
}

@end
