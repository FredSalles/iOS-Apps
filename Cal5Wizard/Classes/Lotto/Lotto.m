//
//  Lotto.m
//  CL
//
//  Created by Frederic Salles on 10/16/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "Lotto.h"

@implementation Lotto
- (Lotto *) initWithDrawCount: (int) drawCount megaCount: (int) megaCount {
	if (!(self = [super init])) return nil;
	draws = malloc(sizeof(int) * drawCount);
	int i;
	for (i=0; i<drawCount; i++) {
		draws[i] = 0;
	}
	megas = malloc(sizeof(int) * megaCount);
	for (i=0; i<megaCount; i++) {
		megas[i] = 0;
	}
	return self;
}
- (void) increaseDraw: (int) draw {
	draws[draw - 1] ++;
}
- (void) increaseMega: (int) mega {
	megas[mega - 1] ++;
}
- (void) resetDraw: (int) draw {
	draws[draw - 1] = 0;
}
- (void) resetMega: (int) mega {
	megas[mega - 1] = 0;
}
- (int) getDraw: (int) draw {
	return draws[draw - 1];
}
- (int) getMega: (int) mega {
	return megas[mega - 1];
}

- (void) setDraw: (int) draw value: (int) value {
	draws[draw -1] = value;
}
- (void) setMega: (int) draw value: (int) value {
	megas[draw -1] = value;
}
@end
