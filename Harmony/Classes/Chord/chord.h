//
//  chord.h
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>

@interface chord : NSObject {

	NSString *name;
	NSString *description;
	NSArray  *notes;
}

-(chord*) init: (NSString*) inName andDescription: (NSString*) inDescription andNotes: (NSArray*) inNotes;

@property (assign) NSString* name;
@property (assign) NSString* description;
@property (assign) NSArray * notes;

@end
