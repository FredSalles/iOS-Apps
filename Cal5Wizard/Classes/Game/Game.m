//
//  Game.m
//  CL
//
//  Created by Frederic Salles on 10/16/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "Game.h"
#import "Draw.h"
#import "CLViewController.h"

@implementation Game
@synthesize GameName;

- (Game *) initWithDrawCount: (int) drawCount drawLimit: (int) dl megaCount: (int) megaCount drawPerGame: (int) dpg megaPerGame: (int) mpg lotteryName: (NSString*) ln gameName: (NSString*) gn url: (NSString *) url {
	if (!(self = [super init])) return nil;
	Appearences = [[Lotto alloc] initWithDrawCount:drawCount megaCount:megaCount];
	Absences = [[Lotto alloc] initWithDrawCount:drawCount megaCount:megaCount]; 
	History = [[Draws alloc] init];
	Dpg = dpg;
	Mpg = mpg;
    DrawLimit = dl;
	LotteryName = ln;
	GameName = gn;
	DrawCount = drawCount;
	MegaCount = megaCount;
	Url = url;
	return self;
}

- (void) reload: (NSObject*) notify {
	Notify = notify;
	// Create the request.
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:Url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];
	// create the connection with the request
	// and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		// Create the NSMutableData to hold the received data.
		// receivedData is an instance variable declared elsewhere.
		receivedData = [NSMutableData data];
	} else {
		// Inform the user that the connection failed.
        CLViewController *c = (CLViewController*) Notify;
		[c failed];
	}
}	

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    CLViewController *c = (CLViewController*) Notify;
	[c failed];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // receivedData is declared as a method instance elsewhere
    //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	NSString *s = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
	NSArray * linesarray = [s componentsSeparatedByString:@"\n"];
	int count=[linesarray count];
	//printf("linesarray count:  %d\n",count);
	int j;
    
    //
    // Start at 5th line
    //
	for (j=5;j<count-1;j++){
		Draw * current;
		current = [[Draw alloc] initDraws: Dpg Megas: Mpg];
		NSString *currentLine =[[NSString alloc] initWithUTF8String: [linesarray[j] UTF8String]];
		NSArray * wordsArray = [currentLine componentsSeparatedByString:@" "];
		int wordsCount=[wordsArray count];
		int currentWordIndex;
		int columnIndex = 1;
		//NSLog(@"====> Processing:%@", currentLine);
		//
		// Processes Draw and Mega Appearences
		//
        current->date = @"";
		for (currentWordIndex=0; currentWordIndex<wordsCount; currentWordIndex++){
			if (![wordsArray[currentWordIndex] isEqualToString: @""]) {
				const char* currentWord = [wordsArray[currentWordIndex] UTF8String];
				if (columnIndex == 1) {
                    //
                    // First column: drawing number
                    //
					int   value  = [wordsArray[currentWordIndex] intValue];
					//printf("Tirage: %s\n", currentWord);
					current->number = value;
				} else if ((columnIndex >= 2) && (columnIndex <=5)){
                    //
                    // Second to fifth column: drawing date
                    //
					//printf("Date: %s\n", currentWord);
                    if ([current->date isEqualToString: @""] ) {
                        current->date = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%s", currentWord]];
                    } else {
                    current->date = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@ %s", current->date, currentWord]];
                    }
				} else if (columnIndex-5 <= Dpg) {
                    //
                    // Regular number column
                    //
					int   value  = [wordsArray[currentWordIndex] intValue];
					[Appearences increaseDraw:value]; 
					[current->draw setDraw:  columnIndex-5 value: value];
					//printf("Draw[%d]: %s\n",columnIndex-5,currentWord);
				} else if (columnIndex-5-Dpg <= Mpg) {
                    //
                    // Mega number column
                    //
					int   value  = [wordsArray[currentWordIndex] intValue];
					[Appearences increaseMega:value]; 
					[current->draw setMega:  columnIndex-5-Dpg value: value];
					//printf("Mega[%d]: %s\n",columnIndex-5-Dpg,currentWord);
				}
				columnIndex++;
			}
		}
		[History->draws addObject:current];
        //
        // Stop at draw limit
        //
        if (current->number == self->DrawLimit) {
            break;
        }
	}
	int i;
	//
	// From oldest to most recent
	//
	for (i = [History->draws count]-1; i >=0; i--) {
		//
		// increase all absences
		//
		int a;
		for (a=1; a <= DrawCount; a++) {
			[Absences increaseDraw:a]; 
		}
		//
		// reset current
		//
		Draw *tmp = History->draws[i]; 
		for (j=1; j<= Dpg; j++) {
			[Absences resetDraw:[tmp->draw getDraw: j]];
		}
	}
	for (i = [History->draws count]-1; i >=0; i--) {
		//
		// increase all absences
		//
		int a;
		for (a=1; a <= MegaCount; a++) {
			[Absences increaseMega:a]; 
		}
		//
		// reset current
		//
		Draw *tmp = History->draws[i]; 
		for (j=1; j<= Mpg; j++) {
			[Absences resetMega:[tmp->draw getMega: j]];
		}
	}
    CLViewController *c = (CLViewController*) Notify;
	[c refresh: self];
}


@end
