//
//  AddPlaceViewController.h
//  ParseSite
//
//  Created by Kiattisak Anoochitarom on 5/9/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPlaceViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *branchField;
@property (nonatomic, weak) IBOutlet UITextField *openField;
@property (nonatomic, weak) IBOutlet UITextField *closeField;
@property (nonatomic, weak) IBOutlet UITextView *descField;

- (IBAction)done:(id)sender;

@end
