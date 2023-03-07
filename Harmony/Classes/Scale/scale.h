//
//  scale.h
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>

@interface scale : NSObject {
	NSString *name;	
	NSString *description;
	NSArray  *notes;
}

-(scale*) init: (NSString*) inName andDescription: (NSString*) inDescription andNotes: (NSArray*) inNotes;
@property (assign) NSString* name;
@property (assign) NSArray* notes;
@property (assign) NSString* description;

@end
