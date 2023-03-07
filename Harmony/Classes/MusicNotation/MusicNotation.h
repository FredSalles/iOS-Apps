//
//  MusicNotation.h
//  iMusic
//
//  Created by Frederic Salles on 5/8/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "chord.h"
#import "key.h"
#import "musicModel.h"


@interface MusicNotation : NSObject {
	musicModel *music;
	NSMutableArray *notes;
	NSArray *dot;
}
-(MusicNotation*) init;
-(void) cleanup;
-(void) displayChord: (chord*) inChord andKey: (int) inKey andView: (UIView*) inView;

@end
