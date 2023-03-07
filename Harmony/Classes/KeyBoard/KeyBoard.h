//
//  KeyBoard.h
//  iMusic
//
//  Created by Frederic Salles on 5/8/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import "chord.h"
#import "key.h"
#import "musicModel.h"

@interface KeyBoard : NSObject {
	musicModel *music;
	NSMutableArray *keys;

}
-(KeyBoard*) init;
-(void) cleanup;

-(void) displayChord: (chord*) inChord andKey: (int) inKey andView: (UIView*) inView;
@end
