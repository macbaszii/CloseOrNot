//
//  ParseSiteViewController.h
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/2/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Places.h"

#import "ParsingData.h"

@interface ParseSiteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, ParsingDataDelegate>

@property (nonatomic, strong) ParsingData *parser;
@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) NSArray *filteredPlaces;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
