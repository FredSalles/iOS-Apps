//
//  GuitarNeck.h
//  iMusic
//
//  Created by Frederic Salles on 5/6/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "chord.h"
#import "key.h"
#import "tuning.h"
#import "musicModel.h"


@interface GuitarNeck : NSObject {

	musicModel *music;
	NSMutableArray *dots;
}

-(GuitarNeck*) init;
-(void) cleanup;
-(void) displayChord: (chord*) inChord andTuning: (tuning*) inTuning andCapo: (int) inCapo andMode: (int) inMode andKey: (int) inKey andView: (UIView*) inView;

@end
