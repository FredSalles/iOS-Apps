//
//  Game.h
//  CL
//
//  Created by Frederic Salles on 10/16/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lotto.h"
#import "Draws.h"

@interface Game : NSObject {
	@public
	NSString *Url;
	NSString *GameName;
	NSString *LotteryName;
	int Dpg;
	int Mpg;
	int DrawCount;
	int MegaCount;
    int DrawLimit;
	Lotto *Appearences;
	Lotto *Absences;
	Draws *History;
	NSObject *Notify;
	NSMutableData *receivedData;
}
- (Game *) initWithDrawCount: (int) drawCount drawLimit: (int) dl  megaCount: (int) megaCount drawPerGame: (int) dpg megaPerGame: (int) mpg lotteryName: (NSString*) ln gameName: (NSString*) gn url: (NSString *) url;
- (void) reload: (NSObject*) notify;
@property (nonatomic, retain) NSString *GameName;
@end
