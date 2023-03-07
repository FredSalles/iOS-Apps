//
//  chordFinder.m
//  iMusic
//
//  Created by Frederic Salles on 5/1/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "chordFinder.h"

@implementation chordFinder

-(chordFinder*) init {

music = [[musicModel alloc] init];
return self;

}

-(void)dealloc {
	[music release];
    [super dealloc];
}



-(int) noteInChord: (int) currentKeyReference andPosition: (NSString *) position andChord: (NSArray *) chord {	
	for (int chordNoteNumber=0; chordNoteNumber < [chord count]; chordNoteNumber++) {
		NSString * currentNote = [chord objectAtIndex: chordNoteNumber];
		NSString * targetNote  = [[music internalToSymbol] objectAtIndex: ((currentKeyReference + [[[music positionToHalftone] objectForKey: position] integerValue]) % 12)];
		if ( [currentNote compare:  targetNote] == NSOrderedSame) {
			return chordNoteNumber;
		}
	}
	return -1;
}
		//
		//
		//
		//
		//
-(NSMutableArray *) findChords: (NSArray *) inChord
{

	//
	// init chordFound objects
	//
	NSMutableArray *chordFoundRootList = [[NSMutableArray alloc] init];
	NSMutableArray *chordFoundNameList = [[NSMutableArray alloc] init];
	NSMutableArray *chordFoundIntervalList = [[NSMutableArray alloc] init];
	
	//
	// Chord Finder Algo Starts Here - Determine Chord Name
	//
	// Chord = C E G
	// Key = C
	//
	// For Each Possible Root
	//
	for (int currentRootNumber=0; currentRootNumber < [inChord count]; currentRootNumber++) {	

		//
		// init current found objects
		//
		NSMutableString *chordFoundRoot = [[NSMutableString alloc] init];
		NSMutableString *chordFoundPrefix = [[NSMutableString alloc] init];
		NSMutableString *chordFoundMiddleNotes = [[NSMutableString alloc] init];
		NSMutableString *chordFoundSuffix = [[NSMutableString alloc] init];
		NSMutableString *chordFoundInterval = [[NSMutableString alloc] init];
		
		//
		// deep copy of original Notes
		//
		NSMutableArray *workingChordCopy=[[NSMutableArray alloc] init];
		[workingChordCopy setArray: inChord];
		
		//
		// current key
		//
		int currentKeyReference = [[[music symbolToInternal] objectForKey: [workingChordCopy  objectAtIndex: currentRootNumber]]integerValue];
		
		//
		// ============ R (first note)
		//
		[chordFoundRoot appendString: [workingChordCopy objectAtIndex: currentRootNumber]];
		[chordFoundInterval appendString: @"1 "];
		[chordFoundPrefix setString:  @""];
		[chordFoundSuffix appendString:  @""];
		[chordFoundMiddleNotes appendString:  @""];

		[workingChordCopy replaceObjectAtIndex: currentRootNumber withObject:@"done"];
		int pos;
		if ((pos = [self noteInChord: currentKeyReference andPosition: @"3" andChord: workingChordCopy]) != -1) {
			//
			// ============ 3 (second note)
			//
			[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
			[chordFoundInterval appendString: @"3 "];
			if ((pos = [self noteInChord: currentKeyReference andPosition: @"5" andChord: workingChordCopy]) != -1) {
				//
				// 5
				//
				[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
				[chordFoundInterval appendString: @"5 "];
			} else {
				//
				// no5
				//
				if (([self noteInChord: currentKeyReference andPosition: @"4#" andChord: workingChordCopy] == -1) && (([self noteInChord: currentKeyReference andPosition: @"5#" andChord: workingChordCopy]) == -1)){
					[chordFoundSuffix appendString: @"(no5) "];
				}
			}
			if ((pos = [self noteInChord: currentKeyReference andPosition: @"6" andChord: workingChordCopy]) != -1) {
				//
				// 6
				//
				[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
				[chordFoundInterval appendString: @"6 "];
				if ((pos = [self noteInChord: currentKeyReference andPosition: @"7b" andChord: workingChordCopy]) != -1) {
					//
					// 7b
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"13 "];
					[chordFoundPrefix setString: @"13"];
				} else {
					//
					// no7b
					//
					[chordFoundPrefix setString: @"6"];
				}
				
			} else {
				//
				// no6
				//
				if ((pos = [self noteInChord: currentKeyReference andPosition: @"7" andChord: workingChordCopy]) != -1) {
					//
					// 7
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"7 "];
					[chordFoundPrefix setString: @"M7"];
				} else if ((pos = [self noteInChord: currentKeyReference andPosition: @"7b" andChord: workingChordCopy]) != -1) {
					//
					// 7b
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"7b "];
					[chordFoundPrefix setString: @"7"];
				} else if ((pos = [self noteInChord: currentKeyReference andPosition: @"5#" andChord: workingChordCopy]) != -1) {
					//
					// 5#
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"5# "];
					[chordFoundPrefix setString: @"aug"];
				}
			}
		} else if ((pos = [self noteInChord: currentKeyReference andPosition: @"3b" andChord: workingChordCopy]) != -1) {
			//
			// ============ 3b (second note)
			//
			[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
			[chordFoundInterval appendString: @"3b "];
			[chordFoundPrefix setString: @"m"];
			if ((pos = [self noteInChord: currentKeyReference andPosition: @"5" andChord: workingChordCopy]) != -1) {
				//
				// 5
				//
				[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
				[chordFoundInterval appendString: @"5 "];
				if ((pos = [self noteInChord: currentKeyReference andPosition: @"6" andChord: workingChordCopy]) != -1) {
					//
					// 6
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"6 "];
					[chordFoundPrefix setString: @"min6"];
				} else if ((pos = [self noteInChord: currentKeyReference andPosition: @"7b" andChord: workingChordCopy]) != -1) {
					//
					// 7b
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"7b "];
					[chordFoundPrefix setString: @"min7"];
				}
			} else {
				//
				// no5
				//
				if ((pos = [self noteInChord: currentKeyReference andPosition: @"4#" andChord: workingChordCopy]) != -1) {
					//
					// 4#
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"4# "];
					if ((pos = [self noteInChord: currentKeyReference andPosition: @"6" andChord: workingChordCopy]) != -1) {
						//
						// 6
						//
						[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
						[chordFoundInterval appendString: @"6 "];
						[chordFoundPrefix setString: @"dim7"];
					} else {
						[chordFoundPrefix setString: @"dim"];
					}
				} else {
					if ((([self noteInChord: currentKeyReference andPosition: @"4#" andChord: workingChordCopy]) == -1) && (([self noteInChord: currentKeyReference andPosition: @"5#" andChord: workingChordCopy]) == -1)){
						[chordFoundSuffix appendString: @"(no5) "];
					}
				}
			}
		} else {
			//
			// no3no3b
			//
			if ((pos = [self noteInChord: currentKeyReference andPosition: @"4" andChord: workingChordCopy]) != -1) {
				//
				// 4
				//
				[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
				[chordFoundInterval appendString: @"4 "];
				[chordFoundPrefix setString: @"sus4"];
				if ((pos = [self noteInChord: currentKeyReference andPosition: @"5" andChord: workingChordCopy]) == -1) {
					//
					// no5
					//
					if ((([self noteInChord: currentKeyReference andPosition: @"4#" andChord: workingChordCopy]) == -1) && (([self noteInChord: currentKeyReference andPosition: @"5#" andChord: workingChordCopy]) == -1)){
					[chordFoundSuffix appendString: @"(no5) "];
					}
				} else {
					//
					// 5
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"5 "];
				}
			} else if ((pos = [self noteInChord: currentKeyReference andPosition: @"2" andChord: workingChordCopy]) != -1) {
				//
				// 2
				//
				[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
				[chordFoundInterval appendString: @"2 "];
				[chordFoundPrefix setString: @"sus2"];
				if ((pos = [self noteInChord: currentKeyReference andPosition: @"5" andChord: workingChordCopy]) == -1) {
					//
					// no5
					//
					if ((([self noteInChord: currentKeyReference andPosition: @"4#" andChord: workingChordCopy]) == -1) && (([self noteInChord: currentKeyReference andPosition: @"5#" andChord: workingChordCopy]) == -1)){
					[chordFoundSuffix appendString: @"(no5) "];
					}
				} else {
					//
					// 5
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"5 "];
				}
			} else {
				//
				// no2no4
				//
				if ((pos = [self noteInChord: currentKeyReference andPosition: @"5" andChord: workingChordCopy]) != -1) {
					//
					// 5
					//
					[workingChordCopy replaceObjectAtIndex: pos withObject:@"done"];
					[chordFoundInterval appendString: @"5 "];
					[chordFoundPrefix setString: @"5th"];
				} else {
					//
					// no5
					//
					if ((([self noteInChord: currentKeyReference andPosition: @"4#" andChord: workingChordCopy]) == -1) && (([self noteInChord: currentKeyReference andPosition: @"5#" andChord: workingChordCopy]) == -1)){
					[chordFoundSuffix appendString: @"(no3) (no5) "];
					} else {
						[chordFoundSuffix appendString: @"(no3) "];
					}
				}
			}
		}
		//
		// Process Remaining Notes
		//
		for (int chordNumber=0; chordNumber < [workingChordCopy count]; chordNumber++) {		
			if ([[workingChordCopy objectAtIndex:chordNumber] compare:  @"done"] != NSOrderedSame) {
				int p =0;
				while ([[[music internalToSymbol] objectAtIndex: ((currentKeyReference + p ) % 12)] compare: [workingChordCopy objectAtIndex:chordNumber]] != NSOrderedSame) {
					p++;
				}

				[chordFoundMiddleNotes appendString: [[music addNote] objectAtIndex: p]];
				[chordFoundMiddleNotes appendString: @" "];

				[chordFoundInterval appendString: [[music halftoneToPosition] objectAtIndex: p]];
				[chordFoundInterval appendString: @" "];
			}
		}
		
		//
		// store result
		//
		[chordFoundRootList addObject: chordFoundRoot];
		[chordFoundRoot release];
		NSMutableString *name = [[NSMutableString alloc] init];
		[name appendString: chordFoundPrefix];
		[chordFoundPrefix release];
		[name appendString: @" "];
		[name appendString: chordFoundMiddleNotes];
		[chordFoundMiddleNotes release];
		[name appendString: chordFoundSuffix];
		[chordFoundSuffix release];
		[chordFoundNameList addObject: name];
		[name release];
		[chordFoundIntervalList addObject: chordFoundInterval];
		[chordFoundInterval release];
		[workingChordCopy removeAllObjects];
		[workingChordCopy release];
	}
	
	NSMutableArray *result=[[NSMutableArray alloc] init];
	[result addObject:chordFoundRootList];
	[result addObject:chordFoundNameList];
	[result addObject:chordFoundIntervalList];
	//////[chordFoundRootList removeAllObjects];
	[chordFoundRootList release];
	//////[chordFoundNameList removeAllObjects];
	[chordFoundNameList release];
	//////[chordFoundIntervalList removeAllObjects];
	[chordFoundIntervalList release];
	return result;
}

@end
