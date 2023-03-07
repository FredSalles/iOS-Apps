//
//  key.h
//  HelloWorld
//
//  Created by Frederic Salles on 4/30/09.
//  Copyright 2009 Apple. All rights reserved.
//

#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>

@interface key : NSObject {
	NSString *name;

}
-(key*) init: (NSString*) inName;

@property (assign) NSString* name;

@end

