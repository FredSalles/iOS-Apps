//
//  KeyBoard.m
//  iMusic
//
//  Created by Frederic Salles on 5/8/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "KeyBoard.h"

@implementation KeyBoard

-(KeyBoard*) init {
	music = [[musicModel alloc] init];
	keys = [[NSMutableArray alloc] init];
	return self;
}

-(void)dealloc {
	[self cleanup];
	[music release];
	[keys release];
    [super dealloc];
}

-(void) cleanup
{
	//
	// Release previous keys
	//
	for (int index =0; index < [keys count]; index++) {
		UIImageView *keyImageView = [keys objectAtIndex: index];
		[keyImageView removeFromSuperview];		
	}
	[keys removeAllObjects];
}
-(void) displayChord: (chord*) inChord andKey: (int) inKey andView: (UIView*) inView {

	BOOL inChordKey[24];
	BOOL isWhite[12] = {YES, NO, YES, NO, YES, YES, NO, YES, NO, YES, NO, YES};
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

	[self cleanup];
	
	//
	// Draw White Keys
	//
	int posX = 30;
	int posY = 150;
	for (int note = 0 ; note <= 23 ; note++) {
		if (isWhite[note % 12] == YES) {
			if (inChordKey[note] == YES) {
				UIImageView *dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"keyBigBlue.png"]];
				dotImageView.center = CGPointMake(posX, posY);
				[inView addSubview:dotImageView];
				[keys addObject: dotImageView];
				[dotImageView release];
				posX+=14;
			} else {
				UIImageView *dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"keyBigWhite.png"]];
				dotImageView.center = CGPointMake(posX, posY);
				[inView addSubview:dotImageView];
				[keys addObject: dotImageView];
				[dotImageView release];
				posX+=14;
			}
		}
	}	

	//
	// Draw Black Keys
	//	
	posX = 37;
	posY = 145;
	for (int note = 0 ; note <= 23 ; note++) {
		if (isWhite[note % 12] == NO) {
			if (inChordKey[note] == YES) {
				UIImageView *dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"keySmallBlue.png"]];
				dotImageView.center = CGPointMake(posX, posY);
				[inView addSubview:dotImageView];
				[keys addObject: dotImageView];
				[dotImageView release];
				if ((note == 3) || (note == 10) || (note == 15)) {
					posX+=28;
				} else {
					posX+=14;
				}
			} else {
				UIImageView *dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"keySmallBlack.png"]];
				dotImageView.center = CGPointMake(posX, posY);
				[inView addSubview:dotImageView];
				[keys addObject: dotImageView];
				[dotImageView release];
				if ((note == 3) || (note == 10) || (note == 15)) {
					posX+=28;
				} else {
					posX+=14;
				}			
			}
		}
	}	
}


@end
