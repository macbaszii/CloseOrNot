//
//  Places.h
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Places : NSManagedObject

@property (nonatomic, retain) NSString * alterNames;
@property (nonatomic, retain) NSString * closeTime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * openTime;
@property (nonatomic, retain) NSString * notes;

@end
