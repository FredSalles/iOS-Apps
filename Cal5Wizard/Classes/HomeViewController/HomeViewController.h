//
//  HomeViewController.h
//  CL
//
//  Created by Frederic Salles on 10/19/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"


@interface HomeViewController : UIViewController {
	UILabel *mega;
	UILabel *number;
	UILabel *date;
	UILabel *lotteryName;
	UILabel *gameName;
	NSMutableArray *bars;
}
@property (nonatomic, strong) IBOutlet UILabel *mega;
@property (nonatomic, strong) IBOutlet UILabel *number;
@property (nonatomic, strong) IBOutlet UILabel *date;
@property (nonatomic, strong) IBOutlet UILabel *lotteryName;
@property (nonatomic, strong) IBOutlet UILabel *gameName;
- (void) refresh: (Game*) source;
- (void) cleanup;
@end
