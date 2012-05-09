//
//  DetailViewController.h
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Places.h"

@interface DetailViewController : UIViewController

@property (nonatomic, weak) Places *placeDetail;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UITextView *noteTextView;

@end
