//
//  HomeViewController.m
//  CL
//
//  Created by Frederic Salles on 10/19/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "Draw.h"


@implementation HomeViewController
@synthesize number;
@synthesize mega;
@synthesize date;
@synthesize lotteryName;
@synthesize gameName;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad]; 
	bars = [[NSMutableArray alloc] init];
}


-(void) cleanup
{
	//
	// Release previous bars
	//
	for (int index =0; index < [bars count]; index++) {
		UIImageView *imageView = bars[index];
		[imageView removeFromSuperview];		
	}	
	[bars removeAllObjects];
}

- (void) refresh: (Game*) game {
	//
	// 	
	[self cleanup];
	Draw *tmp = game->History->draws[0]; 
	int i;
	for (i=1; i<=game->Dpg;i++) {
		UIImageView *dotImageView;
		dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: [[NSString stringWithFormat:@"%d", [tmp->draw getDraw: i]] stringByAppendingString: @".png"]]];
		dotImageView.center = CGPointMake(10+ (i*60), 120);
		[self.view addSubview:dotImageView];
		[bars addObject: dotImageView];
	}
	if (game->Mpg != 0) {
		mega.hidden = NO;
	} else {
		mega.hidden = YES;
	}
	for (i=1; i<=game->Mpg;i++) {
		UIImageView *dotImageView;
		dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: [[NSString stringWithFormat:@"%d", [tmp->draw getMega: i]] stringByAppendingString: @".png"]]];
		dotImageView.center = CGPointMake(350+ (i*60), 120);
		[self.view addSubview:dotImageView];
		[bars addObject: dotImageView];
	}
	//
	lotteryName.text = game->LotteryName;
	gameName.text = game->GameName;
	number.text = [NSString stringWithFormat:@"Draw #%d",tmp->number];
	date.text = tmp->date;
}

//- (void) setGame: (Game*) game {
//	game = theGame;
//}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
