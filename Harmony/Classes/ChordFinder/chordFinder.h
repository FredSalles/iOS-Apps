//
//  chordFinder.h
//  iMusic
//
//  Created by Frederic Salles on 5/1/09.
//  Copyright 2009 Apple. All rights reserved.
//


#import "musicModel.h"

@interface chordFinder : NSObject {
musicModel * music;
}

-(NSMutableArray *) findChords: (NSArray *) chord;
-(chordFinder*) init;
-(int) noteInChord: (int) currentKeyReference andPosition: (NSString *) position andChord: (NSArray *) chord;	
@end
