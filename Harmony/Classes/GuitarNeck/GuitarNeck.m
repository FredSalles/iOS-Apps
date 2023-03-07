//
//  GuitarNeck.m
//  iMusic
//
//  Created by Frederic Salles on 5/6/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "GuitarNeck.h"

@implementation GuitarNeck

-(GuitarNeck*) init {
	music = [[musicModel alloc] init];
	dots = [[NSMutableArray alloc] init];
	return self;
}

-(void)dealloc {
	[self cleanup];
	[music release];
	[dots release];
    [super dealloc];
}

-(void) cleanup
{
	//
	// Release previous dots
	//
	for (int index =0; index < [dots count]; index++) {
		UIImageView *dotImageView = [dots objectAtIndex: index];
		[dotImageView removeFromSuperview];		
	}	
	[dots removeAllObjects];
}

//
//    Symbol    : A Bb B C C# D Eb E F F# G  G#
//    Normalized: 0 1  2 3 4  5 6  7 8 9  10 11
//
-(void) displayChord: (chord*) inChord andTuning: (tuning*) inTuning  andCapo: (int) inCapo andMode: (int) inMode andKey: (int) inKey andView: (UIView*) inView {
	int currentKeyReference = inKey;
	//
	// Release previous dots
	//
	[self cleanup];
	//
	// For each String
	//
	for (int stringNumber = 5; stringNumber >= 0; stringNumber--) {
		//
		// For each Fret
		//
		for (int fretNumber = 0; fretNumber <= 11; fretNumber++) {
			//
			// Current note in the Chord ?
			//
			int currentTuningNoteReference = [[[music symbolToInternal] objectForKey: [[inTuning notes] objectAtIndex: stringNumber]] integerValue];
			int currentFretNoteReference = ( currentTuningNoteReference + fretNumber) % 12;
			//
			// For each chord Note
			//
			for (int chordNoteNumber=0; chordNoteNumber < [[inChord notes] count]; chordNoteNumber++) {
				int currentChordNoteReference = (currentKeyReference + [[[music positionToHalftone] objectForKey: [[inChord notes] objectAtIndex: chordNoteNumber]] integerValue]) % 12;
				if ((currentFretNoteReference == currentChordNoteReference) && (inCapo <= fretNumber)) {
					//
					// Display Dot
					//
					UIImageView *dotImageView;
					if ( inMode == 1) {
						dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: [[[music internalToSymbol] objectAtIndex: currentChordNoteReference] stringByAppendingString: @".png"]]];
					} else if ( inMode == 0) {
						dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: [[[inChord notes] objectAtIndex: chordNoteNumber] stringByAppendingString: @".png"]]];
					} else {
						dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"dotPlainYellow.png"]];
					}
					
					int capoLocation[] = { 7, 45, 94, 140, 183, 223, 262, 298, 332, 364, 395, 422}; 
					int dotsLocation[] = { 0, 0, 1, 2, 2, 2,3,3,3,4,4,4}; 

					dotImageView.center = CGPointMake(capoLocation[fretNumber]+3, 19 + (dotsLocation[fretNumber]+ 15)*(5-stringNumber));
					[inView addSubview:dotImageView];
					[dots addObject: dotImageView];
					[dotImageView release];
					break;
				}
			}
		}
	}
}



@end
