//
//  MusicNotation.m
//  iMusic
//
//  Created by Frederic Salles on 5/8/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "MusicNotation.h"


@implementation MusicNotation

-(MusicNotation*) init {
	music = [[musicModel alloc] init];
	notes = [[NSMutableArray alloc] init];
	
	dot=[[NSArray alloc] initWithObjects: 
				  @"dotstroke.png",
				  @"#dotstroke.png",
				  @"dot.png",
				  @"bdot.png",
				  @"dot.png",
				  @"dot.png",
				  @"#dot.png",
				  @"dot.png",
				  @"#dot.png",
				  @"dot.png",
				  @"bdot.png",
				  @"dot.png", 
				  @"dot.png",
				  @"#dot.png",
				  @"dot.png",
				  @"bdot.png",
				  @"dot.png",
				  @"dot.png",
				  @"#dot.png",
				  @"dot.png",
				  @"#dot.png",
				  @"dotstroke.png",
				  @"bdot.png",
				  @"dot.png", 
				  nil
				  ];
	return self;
}

-(void)dealloc {
	[self cleanup];
	[music release];
	[notes removeAllObjects];
	[notes release];
	[dot release];
    [super dealloc];
}

-(void) cleanup
{
	//
	// Release previous notes
	//
	for (int index =0; index < [notes count]; index++) {
		UIImageView *noteImageView = [notes objectAtIndex: index];
		[noteImageView removeFromSuperview];		
	}	
	[notes removeAllObjects];
}

-(void) displayChord: (chord*) inChord andKey: (int) inKey andView: (UIView*) inView {
	
	BOOL inChordKey[24];
	for (int note = 0 ; note <= 23 ; note++) {
		inChordKey[note] = NO;
	}	
	
	//
	// Look for the ROOT index 
	//
	int rootIndex = 0;
	int currentKeyReference = inKey;
	int firstChordNoteReference = (currentKeyReference + [[[music positionToHalftone] objectForKey: [[inChord notes] objectAtIndex: 0]] integerValue]) % 12;
	for (int note = 3 ; note <= 26 ; note++) {
		if (((note % 12) == firstChordNoteReference)) {
			rootIndex = note - 3;
			break;
		}
	}
	
	//
	// Mark notes in chord
	//
	for (int currentChordNote = 0 ; currentChordNote < [[inChord notes] count]; currentChordNote++) {
		int halfTone = [[[music positionToHalftone] objectForKey: [[inChord notes] objectAtIndex: currentChordNote]] integerValue];
		inChordKey[rootIndex + halfTone] = YES;
	}
	
	//
	// Draw Notes
	//
	int step[24] = {0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0};
	
	[self cleanup];

	int posX = 60;
	int posY = 237;
	int posYStep = 4;
	for (int note = 0 ; note <= 23 ; note++) {
		if (inChordKey[note] == YES) {
			UIImageView *dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: [dot objectAtIndex: note]]];
			dotImageView.center = CGPointMake(posX, posY);
			[inView addSubview:dotImageView];
			[notes addObject: dotImageView];
			[dotImageView release];
			posY-= step[note] * posYStep;
			posX+=20;
		} else {
			posY-= step[note] * posYStep
			;
		}
	}
}

@end
