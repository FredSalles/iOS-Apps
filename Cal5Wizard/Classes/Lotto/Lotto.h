//
//  Lotto.h
//  CL
//
//  Created by Frederic Salles on 10/16/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lotto : NSObject {
	@public
	int *draws;
	int *megas;
}
- (Lotto *) initWithDrawCount: (int) drawCount megaCount: (int) megaCount;
- (void) increaseDraw: (int) draw;
- (void) increaseMega: (int) mega;
- (void) resetDraw: (int) draw;
- (void) resetMega: (int) mega;
- (int) getDraw: (int) draw;
- (int) getMega: (int) mega;
- (void) setDraw: (int) draw value: (int) value;
- (void) setMega: (int) draw value: (int) value;
@end
