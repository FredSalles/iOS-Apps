//
//  Strum.h
//  iMusic
//
//  Created by Frederic Salles on 5/14/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "Strum.h"
#import "chord.h"
#import "key.h"
#import "SoundEffect.h"
#import "musicModel.h"

@interface Strum : NSObject {
	musicModel *music;

}
-(Strum*) init;

-(void) play: (chord*) inChord andKey: (int) inKey;

@end
