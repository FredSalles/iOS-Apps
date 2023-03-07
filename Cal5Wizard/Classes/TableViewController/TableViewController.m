//
//  TableViewController.m
//  CL
//
//  Created by Frederic Salles on 10/19/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "TableViewController.h"
#import "Draw.h"


@implementation TableViewController
@synthesize tableView;
@synthesize	imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
	tableView.backgroundColor = [UIColor clearColor];// UIFont
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (game == nil) {
		return 0;
	}
    return [game->History->draws count];
}

- (void) refresh: (Game*) theGame {
	game = theGame;
	[tableView reloadData];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
	Draw *tmp = game->History->draws[[indexPath indexAtPosition: 1]]; 
	
	NSString *content =[NSString stringWithFormat:@"#%d (",tmp->number];
	content = [content stringByAppendingString: tmp->date];
	content = [content stringByAppendingString: @") "];
	int i;
	for (i=1; i<=game->Dpg;i++) {
		if ([tmp->draw getDraw: i] < 10) {
			content = [content stringByAppendingString:@"0"];
		}
		content = [content stringByAppendingString:[NSString stringWithFormat:@"%d",[tmp->draw getDraw: i]]];
		content = [content stringByAppendingString:@" "];
	}
	if (game->Mpg != 0) {
	content = [content stringByAppendingString:@" mega "];
	for (i=1; i<=game->Mpg;i++) {
		if ([tmp->draw getMega: i] < 10) {
			content = [content stringByAppendingString:@"0"];
		}
		content = [content stringByAppendingString:[NSString stringWithFormat:@"%d",[tmp->draw getMega: i]]];
		content = [content stringByAppendingString:@" "];
	}
	}
    cell.textLabel.text=content;
	cell.backgroundColor=[UIColor clearColor];
	cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}




@end

