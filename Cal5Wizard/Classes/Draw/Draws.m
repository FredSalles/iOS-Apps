//
//  Draws.m
//  CL
//
//  Created by Frederic Salles on 10/17/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "Draws.h"


@implementation Draws
- (Draws *) init {
	if (!(self = [super init])) return nil;
	draws = [[NSMutableArray alloc] init];
	return self;
}

@end
