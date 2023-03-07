//
//  Draw.h
//  CL
//
//  Created by Frederic Salles on 10/17/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lotto.h"

@interface Draw : NSObject {
	@public
	int number;
	NSString *date;
	Lotto *draw;
}
- (Draw *) initDraws: (int) draws Megas: (int) megas;
@end
