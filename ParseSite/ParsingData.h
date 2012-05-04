//
//  ParsingData.h
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/3/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Places.h"

@class ParsingData;

@protocol ParsingDataDelegate
- (void)paringDataDidFinished:(ParsingData *)controller;
@end

@interface ParsingData : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, weak) id <ParsingDataDelegate> delegate;

- (void)setupParseService;
- (void)getFromWebService;
- (NSArray *)fetchPlacesData;

@end
