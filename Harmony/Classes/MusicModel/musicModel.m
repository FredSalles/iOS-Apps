//
//  musicModel.m
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "musicModel.h"
#import "chord.h"
#import "scale.h"
#import "tuning.h"
#import "position.h"
#import "key.h"


@implementation musicModel

@synthesize chords;
@synthesize keys;
@synthesize scales;
@synthesize tunings;
@synthesize capos;
@synthesize symbolToInternal;
@synthesize internalToSymbol;
@synthesize positionToHalftone;
@synthesize symbolToOrder;
@synthesize views;
@synthesize addNote;
@synthesize orderedSymbol;
@synthesize halftoneToPosition;

-(void)dealloc {
	[majorPositions release];
	[minorPositions release];
	[chords release];
	[scales release];
	[tunings release];
	[keys release];
	[super dealloc];
}
-(musicModel*) init {

	majorPositions = [[NSArray alloc] initWithObjects:
					  [[[position alloc] init: @"-- no position selected --" andOffsets: nil andBase: nil] autorelease],
					  [[[position alloc] init: @"A like moveable" andOffsets: [[NSArray alloc] initWithObjects: @"0", @"0", @"2", @"2", @"2", @"0", nil] andBase: @"1"] autorelease],
					  [[[position alloc] init: @"E like moveable" andOffsets: [[NSArray alloc] initWithObjects: @"0", @"2", @"2", @"1", @"0", @"0", nil] andBase: @"0"] autorelease],
					  nil
					  ];
	minorPositions = [[NSArray alloc] initWithObjects:
					  [[[position alloc] init: @"-- no position selected --" andOffsets: nil andBase: nil] autorelease],
					  [[[position alloc] init: @"A like moveable" andOffsets: [[NSArray alloc] initWithObjects: @"0", @"0", @"2", @"2", @"1", @"0", nil] andBase: @"1"] autorelease],
					  [[[position alloc] init: @"E like moveable" andOffsets: [[NSArray alloc] initWithObjects: @"0", @"2", @"2", @"0", @"0", @"0", nil] andBase: @"0"] autorelease],
					  nil
					  ];

	
	chords = [[NSArray alloc] initWithObjects:
			  [[[chord alloc] init: @"Major" andDescription: @"(1 3 5)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"3", @"5", nil]] autorelease],
			  [[[chord alloc] init: @"Major 6" andDescription: @"(1 3 5 6)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"3", @"5", @"6", nil]] autorelease],
			  [[[chord alloc] init: @"Major 7" andDescription: @"(1 3 5 7)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"3", @"5", @"7", nil]] autorelease],
			  [[[chord alloc] init: @"Minor" andDescription: @"(1 3b 5)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"5", nil]] autorelease],
			  [[[chord alloc] init: @"Minor 7" andDescription: @"(1 3b 5 7b)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"5", @"7b", nil]] autorelease],
			  [[[chord alloc] init: @"Minor 7 flat 5" andDescription: @"(1 3b 4# 7b)"	andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"4#", @"7b", nil]] autorelease],
			  [[[chord alloc] init: @"Minor 6" andDescription: @"(1 3b 5 6)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"5", @"6", nil]] autorelease],
			  [[[chord alloc] init: @"Minor/Major 7" andDescription: @"(1 3b 5 7)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"5", @"7", nil]] autorelease],
			  [[[chord alloc] init: @"Suspended 2" andDescription: @"(1 2 5)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"5", nil]] autorelease],
			  [[[chord alloc] init: @"Suspended 4" andDescription: @"(1 4 5)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"4", @"5", nil]] autorelease],
			  [[[chord alloc] init: @"Diminished" andDescription: @"(1 3b 4#)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"4#", nil]] autorelease],
			  [[[chord alloc] init: @"Diminished 7" andDescription: @"(1 3b 4# 7bb)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"4#", @"6", nil]] autorelease],
			  [[[chord alloc] init: @"Augmented" andDescription: @"(1 3 5#)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"3", @"5#", nil]] autorelease],
			  [[[chord alloc] init: @"Augmented 7" andDescription: @"(1 3 5# 7b)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"3", @"5#", @"7b", nil]] autorelease],
			  [[[chord alloc] init: @"Dominant 7" andDescription: @"(1 3 5 7b)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"3", @"5", @"7b", nil]] autorelease],
			  [[[chord alloc] init: @"Dominant 7 flat 5" andDescription: @"(1 3 4# 7b)"	andNotes: [[NSArray alloc] initWithObjects: @"1", @"3", @"4#", @"7b", nil]] autorelease],
			  [[[chord alloc] init: @"Dominant 7 Suspended 4" andDescription: @"(1 4 5 7b)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"4", @"5", @"7b", nil]] autorelease],
			  [[[chord alloc] init: @"5th" andDescription: @"(1 5)"					andNotes: [[NSArray alloc] initWithObjects: @"1", @"5", nil]] autorelease],
			  nil
			  ];
		
	scales = [[NSArray alloc] initWithObjects:
			  [[[scale alloc] init: @"Major" andDescription: @"(1 2 3 4 5 6 7)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", @"7", nil]] autorelease],
			  [[[scale alloc] init: @"Minor" andDescription: @"(1 2 3b 4 5 5# 7b)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3b", @"4", @"5", @"5#", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Major Pentatonic" andDescription: @"(1 2 3 5 6)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"5", @"6", nil]] autorelease],
			  [[[scale alloc] init: @"Minor Pentatonic" andDescription: @"(1 3b 4 5 7b)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"4", @"5", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Harmonic Minor" andDescription: @"(1 2 3b 4 5 5# 7)"	andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3b", @"4", @"5", @"5#", @"7", nil]] autorelease],
			  [[[scale alloc] init: @"Melodic Minor " andDescription: @"(1 2 3b 4 5 6 7)"	andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3b", @"4", @"5", @"6", @"7", nil]] autorelease],
			  [[[scale alloc] init: @"Blues" andDescription: @"(1 3b 4 4# 5 7b)"				andNotes: [[NSArray alloc] initWithObjects: @"1", @"3b", @"4", @"4#", @"5", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Dorian" andDescription: @"(1 2 3b 4 5 6 7b)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3b", @"4", @"5", @"6", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Phrygian" andDescription: @"(1 1# 3b 4 5 5# 7b)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"1#", @"3b", @"4", @"5", @"5#", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Lydian" andDescription: @"(1 2 3 4# 5 6 7)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4#", @"5", @"6", @"7", nil]] autorelease],
			  [[[scale alloc] init: @"Mixolydian" andDescription: @"(1 2 3 4 5 6 7b)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Aeolian" andDescription: @"(1 2 3b 4 5 5# 7b)"			andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3b", @"4", @"5", @"5#", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Locrian" andDescription: @"(1 1# 3b 4 4# 5# 7b)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"1#", @"3b", @"4", @"4#", @"5#", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Whole Tone" andDescription: @"(1 2 3 4# 5# 7b)"		andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4#", @"5#", @"7b", nil]] autorelease],
			  [[[scale alloc] init: @"Whole-Half Diminished" andDescription: @"(1 2 3b 4 4# 5# 6 7)"	andNotes: [[NSArray alloc] initWithObjects: @"1", @"2", @"3b", @"4", @"4#", @"5#", @"6", @"7", nil]] autorelease],
			  [[[scale alloc] init: @"Half-Whole Diminished" andDescription: @"(1 1# 3b 3 4# 5 6 7b)"	andNotes: [[NSArray alloc] initWithObjects: @"1", @"1#", @"3b", @"3", @"4#", @"5", @"6", @"7b", nil]] autorelease],
			  nil
			  ];
	
	tunings = [[NSArray alloc] initWithObjects:
			   [[[tuning alloc] init: @"Standard" andDescription: @"E A D G B E"				andNotes: [[NSArray alloc] initWithObjects: @"E", @"A", @"D", @"G", @"B", @"E", nil]] autorelease],
			   [[[tuning alloc] init: @"Drop D" andDescription: @"D A D G B E"				andNotes: [[NSArray alloc] initWithObjects: @"D", @"A", @"D", @"G", @"B", @"E", nil]] autorelease],
			   [[[tuning alloc] init: @"D Modal" andDescription: @"D A D G A D"				andNotes: [[NSArray alloc] initWithObjects: @"D", @"A", @"D", @"G", @"A", @"D", nil]] autorelease],
			   [[[tuning alloc] init: @"Open G" andDescription: @"D G D G B D"				andNotes: [[NSArray alloc] initWithObjects: @"D", @"G", @"D", @"G", @"B", @"D", nil]] autorelease],
			   [[[tuning alloc] init: @"Open Gm" andDescription: @"D G D G Bb D"				andNotes: [[NSArray alloc] initWithObjects: @"D", @"G", @"D", @"G", @"Bb", @"D", nil]] autorelease],
			   [[[tuning alloc] init: @"E Modal" andDescription: @"E A D E A E"				andNotes: [[NSArray alloc] initWithObjects: @"E", @"A", @"D", @"E", @"A", @"E", nil]] autorelease],
			   [[[tuning alloc] init: @"Open G (C bass)" andDescription: @"C G D G B D"		andNotes: [[NSArray alloc] initWithObjects: @"C", @"G", @"D", @"G", @"B", @"D", nil]] autorelease],
			   [[[tuning alloc] init: @"Open D" andDescription: @"D A D F# A D"				andNotes: [[NSArray alloc] initWithObjects: @"D", @"A", @"D", @"F#", @"A", @"D", nil]] autorelease],
			   [[[tuning alloc] init: @"Open Dm" andDescription: @"D A D F A D"				andNotes: [[NSArray alloc] initWithObjects: @"D", @"A", @"D", @"F", @"A", @"D", nil]] autorelease],
			   [[[tuning alloc] init: @"Open Dm (C bass)" andDescription: @"C A D F A D"		andNotes: [[NSArray alloc] initWithObjects: @"C", @"A", @"D", @"F", @"A", @"D", nil]] autorelease],
			   [[[tuning alloc] init: @"Open E" andDescription: @"E B E G# B E"				andNotes: [[NSArray alloc] initWithObjects: @"E", @"B", @"E", @"G#", @"B", @"E", nil]] autorelease],
			   [[[tuning alloc] init: @"Open A" andDescription: @"E A E A C# E"				andNotes: [[NSArray alloc] initWithObjects: @"E", @"A", @"E", @"A", @"C#", @"E", nil]] autorelease],
			   [[[tuning alloc] init: @"Lute" andDescription: @"E A D F# B E"				andNotes: [[NSArray alloc] initWithObjects: @"E", @"A", @"D", @"F#", @"B", @"E", nil]] autorelease],
			   [[[tuning alloc] init: @"Blues" andDescription: @"E A D G C F"				andNotes: [[NSArray alloc] initWithObjects: @"E", @"A", @"D", @"G", @"C", @"F", nil]] autorelease],
			   nil
			   ];
	
	keys = [[NSArray alloc] initWithObjects:
			[[[key alloc] init: @"C"] autorelease],
			[[[key alloc] init: @"C#"] autorelease],
			[[[key alloc] init: @"D"] autorelease],
			[[[key alloc] init: @"Eb"] autorelease],
			[[[key alloc] init: @"E"] autorelease],
			[[[key alloc] init: @"F"] autorelease],
			[[[key alloc] init: @"F#"] autorelease],
			[[[key alloc] init: @"G"] autorelease],
			[[[key alloc] init: @"G#"] autorelease],
			[[[key alloc] init: @"A"] autorelease],
			[[[key alloc] init: @"Bb"] autorelease],
			[[[key alloc] init: @"B"] autorelease],
			nil
			];
	
	capos = [[NSArray alloc] initWithObjects:
			@"none",
			@"1",
			@"2",
			@"3",
			@"4",
			@"5",
			@"6",
			@"7",
			@"8",
			@"9",
			@"10",
			@"11",
			nil
			];
	
	internalToSymbol = [[NSArray alloc] initWithObjects:
						@"A",
						@"Bb",
						@"B",
						@"C",
						@"C#",
						@"D",
						@"Eb",
						@"E",
						@"F",
						@"F#",
						@"G",
						@"G#",
						nil
						];
	
	orderedSymbol = [[NSArray alloc] initWithObjects:
					 @"C",
					 @"C#",
					 @"D",
					 @"Eb",
					 @"E",
					 @"F",
					 @"F#",
					 @"G",
					 @"G#",
					 @"A",
					 @"Bb",
					 @"B",
					 nil
					 ];
	
	addNote = [[NSArray alloc] initWithObjects:
			   @"___R___", //R
			   @"-9",
			   @"add9",
			   @"add3",
			   @"___3___", //3
			   @"sus4",
			   @"flat5",
			   @"___5___", //5
			   @"aug5",
			   @"6",
			   @"maj7",
			   @"dom7",
			   nil
			   ];

	views = [[NSArray alloc] initWithObjects:
			   @"Notes",
			   @"Intervals",
			   @"Plain",
			 nil
			 ];
			   
	halftoneToPosition= [[NSArray alloc] initWithObjects:
						 @"1",
						 @"1#",
						 @"2",
						 @"3b",
						 @"3",
						 @"4",
						 @"4#",
						 @"5",
						 @"5#",
						 @"6",
						 @"7b",
						 @"7",
						 nil
						 ];
	
	symbolToInternal = [[NSDictionary alloc] initWithObjectsAndKeys: 
						@"0", @"A",
						@"1", @"Bb",
						@"2", @"B",
						@"3", @"C",
						@"4", @"C#",
						@"5", @"D",
						@"6", @"Eb",
						@"7", @"E",
						@"8", @"F",
						@"9", @"F#",
						@"10", @"G",
						@"11", @"G#",						
						nil
						];
	symbolToOrder = [[NSDictionary alloc] initWithObjectsAndKeys: 
						@"12", @"A",
						@"13", @"Bb",
						@"14", @"B",
						@"3", @"C",
						@"4", @"C#",
						@"5", @"D",
						@"6", @"Eb",
						@"7", @"E",
						@"8", @"F",
						@"9", @"F#",
						@"10", @"G",
						@"11", @"G#",						
						nil
						];
	
	symbolToMidi  = [[NSDictionary alloc] initWithObjectsAndKeys: 
					 @"57", @"A",
					 @"58", @"Bb",
					 @"59", @"B",
					 @"48", @"C",
					 @"49", @"C#",
					 @"50", @"D",
					 @"51", @"Eb",
					 @"52", @"E",
					 @"53", @"F",
					 @"54", @"F#",
					 @"55", @"G",
					 @"56", @"G#",						
					 nil
					 ];
	
	positionToHalftone  = [[NSDictionary alloc] initWithObjectsAndKeys: 
						   @"0", @"1",
						   @"1", @"1#",
						   @"2", @"2",
						   @"3", @"3b",
						   @"4", @"3",
						   @"5", @"4",
						   @"6", @"4#",
						   @"7", @"5",
						   @"8", @"5#",
						   @"9", @"6",
						   @"10", @"7b",
						   @"11", @"7",						
						   nil
						   ];

	return self;
}

@end
