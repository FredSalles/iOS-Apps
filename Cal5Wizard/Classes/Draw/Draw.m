//
//  Draw.m
//  CL
//
//  Created by Frederic Salles on 10/17/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "Draw.h"


@implementation Draw
- (Draw *) initDraws: (int) draws Megas: (int) megas {
	if (!(self = [super init])) return nil;
	draw = [[Lotto alloc] initWithDrawCount: draws megaCount: megas];
	return self;
}

@end
