//
//  Strum.m
//  iMusic
//
//  Created by Frederic Salles on 5/14/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "Strum.h"


@implementation Strum

-(Strum*) init {
	music = [[musicModel alloc] init];
	return self;
}

-(void)dealloc {
	[music release];
    [super dealloc];
}

-(void) play: (chord*) inChord andKey: (int) inKey
{
	NSBundle *mainBundle = [NSBundle mainBundle];
	SoundEffect * sound;
	int firstHighest = -1;
	bool once = true;
	//
	// One note at a time
	//
	int currentKeyReference = inKey;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	for (int currentChordNote = 0 ; currentChordNote < [[inChord notes] count]; currentChordNote++) {
		int currentChordNoteReference = (currentKeyReference + [[[music positionToHalftone] objectForKey: [[inChord notes] objectAtIndex: currentChordNote]] integerValue]) % 12;
		NSMutableString *currentChordNote = [[[NSMutableString alloc] init] autorelease];
		[currentChordNote appendString: [[music internalToSymbol]objectAtIndex:currentChordNoteReference]];
		int currentChordNoteAbs = [[[music symbolToOrder] objectForKey: currentChordNote] integerValue];
		if ((firstHighest > currentChordNoteAbs) && (once == true)) {
			once = false;
		}
		if (once == false) {
			[currentChordNote appendString: @"+"];
		} else if (firstHighest < currentChordNoteAbs) {
			firstHighest = currentChordNoteAbs;
		}
		sound = [[[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:currentChordNote ofType:@"caf"]] autorelease];
		[sound play];
		[NSThread sleepForTimeInterval:1];
	}
	//
	// All note at a time
	//
	firstHighest = -1;
	once = true;
	for (int currentChordNote = 0 ; currentChordNote < [[inChord notes] count]; currentChordNote++) {
		int currentChordNoteReference = (currentKeyReference + [[[music positionToHalftone] objectForKey: [[inChord notes] objectAtIndex: currentChordNote]] integerValue]) % 12;
		NSMutableString *currentChordNote = [[[NSMutableString alloc] init] autorelease];
		[currentChordNote appendString: [[music internalToSymbol]objectAtIndex:currentChordNoteReference]];
		int currentChordNoteAbs = [[[music symbolToOrder] objectForKey: currentChordNote] integerValue];
		if ((firstHighest > currentChordNoteAbs) && (once == true)) {
			once = false;
		}
		if (once == false) {
			[currentChordNote appendString: @"+"];
		} else if (firstHighest < currentChordNoteAbs) {
			firstHighest = currentChordNoteAbs;
		}
		sound = [[[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:currentChordNote ofType:@"caf"]] autorelease];		
		[sound play];
	}
	[NSThread sleepForTimeInterval:2];
	[pool release];
}

@end









