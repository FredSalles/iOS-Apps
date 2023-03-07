//
//  position.h
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>

@interface position : NSObject {
	NSString *name;
	NSArray *offsets;
	NSString *base;
}

-(position*) init: (NSString*) inName andOffsets: (NSArray*) inOffsets andBase: (NSString*) inBase;

@end
