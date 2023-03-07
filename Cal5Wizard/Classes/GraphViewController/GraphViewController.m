//
//  GraphViewController.m
//  CL
//
//  Created by Frederic Salles on 10/18/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "GraphViewController.h"


@implementation GraphViewController
@synthesize mega;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/
- (void) refresh: (Game*) game {
	//
	// 	
	[self cleanup];
	//
	if (game->Mpg != 0) {
		mega.hidden = NO;
	} else {
		mega.hidden = YES;
	}
	int i;
	int barsize=100;
	//
	// Draw MAX
	//	
	int offset = 6;
	int decy= 0;
	if (game->DrawCount >=50) {
		offset = 4;
		decy=-10;
		
	}
	int maxDraw = 0;
	int maxMega = 0;
	int allDraws[game->DrawCount];
	int allMegas[game->MegaCount];
	for (i = 1 ; i <= game->DrawCount ; i++) {
		allDraws[i-1] = [game->Appearences getDraw: i];
	}
	for (i = 1 ; i <= game->MegaCount ; i++) {
		allMegas[i-1] = [game->Appearences getMega: i];
	}
	for (i =game->DrawCount-1 ; i >=1; i--) {
		int j;
		for (j =i; j>=1; j--) {
			if (allDraws[j] > allDraws[j-1]) {
				int tmp = allDraws[j];
				allDraws[j] = allDraws[j-1];
				allDraws[j-1] = tmp;
			}
		}
	}
	for (i =game->MegaCount-1 ; i >=1; i--) {
		int j;
		for (j =i; j>=1; j--) {
			if (allMegas[j] > allMegas[j-1]) {
				int tmp = allMegas[j];
				allMegas[j] = allMegas[j-1];
				allMegas[j-1] = tmp;
			}
		}
	}
	for (i = 1 ; i <= game->DrawCount ; i++) {
		if([game->Appearences getDraw: i] > maxDraw) {
			maxDraw = [game->Appearences getDraw: i];
		}
	}
	for (i = 1 ; i <= game->MegaCount ; i++) {
		if([game->Appearences getMega: i] > maxMega) {
			maxMega = [game->Appearences getMega: i];
		}
	}	
	int off=0;	
	for (i = 1 ; i <= game->DrawCount ; i++) {
		UIImageView *dotImageView;
		BOOL found = false;
		int j;
		for (j = 0 ; j <=4; j++) {
			if (allDraws[j] == [game->Appearences getDraw: i]) {
				found = true;
				break;
			}
		}
		if	(found == false) {
			if (game->DrawCount >=50) {
					dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"barHigh_small.png"]];
			}else{
					dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"barHigh.png"]];
			}
			} else {			
				if (game->DrawCount >=50) {
					dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"bar_small.png"]];
				} else {
			dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"bar.png"]];
				}
			if (off <5) {
				UIImageView *dotImageView1;
				dotImageView1= [[UIImageView alloc] initWithImage:[UIImage imageNamed: [[NSString stringWithFormat:@"%d", i] stringByAppendingString: @".png"]]];
				dotImageView1.center = CGPointMake(50+ (off*52), 90);
				off++;
				[self.view addSubview:dotImageView1];
				[bars addObject: dotImageView1];
			}
		}
		CGRect frame = dotImageView.frame;
		int height = (float)[game->Appearences getDraw: i] / (float)maxDraw * (float)barsize;
		frame.size.height = height;
		dotImageView.frame = frame;		
		dotImageView.center = CGPointMake(10+ (i*offset), 178 + (barsize-height)/2);
		[self.view addSubview:dotImageView];
		[bars addObject: dotImageView];
	}
	off=0;
	for (i = 1 ; i <= game->MegaCount ; i++) {
		UIImageView *dotImageView;
		BOOL found = false;
		int j;
		for (j = 0 ; j <=2; j++) {
			if (allMegas[j] == [game->Appearences getMega: i]) {
				found = true;
				break;
			}
		}
		if	(found == false) {
			if (game->DrawCount >=50) {
				dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"barHigh_small.png"]];
			}else{
		dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"barHigh.png"]];
				}
		} else {
			if (game->DrawCount >=50) {
				dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"bar_small.png"]];
			} else {
			dotImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"bar.png"]];
			}
			if (off <3) {
				UIImageView *dotImageView1;
				dotImageView1= [[UIImageView alloc] initWithImage:[UIImage imageNamed: [[NSString stringWithFormat:@"%d", i] stringByAppendingString: @".png"]]];
				dotImageView1.center = CGPointMake(330+ (off*52), 90);
				off++;
				[self.view addSubview:dotImageView1];
				[bars addObject: dotImageView1];
			}
		}
		CGRect frame = dotImageView.frame;
		int height = (float)[game->Appearences getMega: i] / (float)maxMega * (float)barsize;
		frame.size.height = height;
		dotImageView.frame = frame;	
		dotImageView.center = CGPointMake(300+ (i*offset)+decy, 178+ (barsize-height)/2);
		[self.view addSubview:dotImageView];
		[bars addObject: dotImageView];
	}
}



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
