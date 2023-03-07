//
//  TableViewController.h
//  CL
//
//  Created by Frederic Salles on 10/20/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"


@interface TableViewController : UIViewController {
	Game *game;
	UITableView *tableView;
	UIImageView *imageView;
}
- (void) refresh: (Game*) game;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
