//
//  musicModel.h
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>

@interface musicModel : NSObject {
	NSAutoreleasePool *pool;
	NSArray *internalToSymbol;
	NSArray *halftoneToPosition;

	NSArray *orderedSymbol;
	NSArray *addNote;
	
	NSArray *majorPositions;
	NSArray *minorPositions;
	NSArray *emptyPositions;

	NSArray *chords;
	NSArray *scales;
	NSArray *tunings;
	NSArray *keys;
	NSArray *capos;
	
	NSArray *views;

	NSDictionary *symbolToOrder;
	NSDictionary *symbolToInternal;
	NSDictionary *symbolToMidi;
	NSDictionary *positionToHalftone;
}

-(musicModel*) init;

@property (assign) NSArray* chords;
@property (assign) NSArray* keys;
@property (assign) NSArray* scales;
@property (assign) NSArray *tunings;
@property (assign) NSArray *capos;
@property (assign) NSArray *addNote;
@property (assign) NSArray *halftoneToPosition;
@property (assign) NSDictionary *symbolToInternal;
@property (assign) NSArray *internalToSymbol;
@property (assign) NSArray *orderedSymbol;
@property (assign) NSArray *views;
@property (assign) NSDictionary *positionToHalftone;
@property (assign) NSDictionary *symbolToOrder;





@end
