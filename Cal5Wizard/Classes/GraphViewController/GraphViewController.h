//
//  GraphViewController.h
//  CL
//
//  Created by Frederic Salles on 10/18/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"


@interface GraphViewController : UIViewController {
	NSMutableArray *bars;
	UILabel *mega;
}
- (void) refresh: (Game*) game;
- (void) cleanup;
@property (nonatomic, strong) IBOutlet UILabel *mega;

@end
