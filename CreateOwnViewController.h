//
//  CreateOwnViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateOwnViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *eventDateField;
@property (strong, nonatomic) IBOutlet UITextField *eventDetailsField;

- (IBAction)saveOwnTradition:(id)sender;
- (IBAction)uploadPhoto:(id)sender;

@end
