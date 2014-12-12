//
//  LoginViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/26/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>{

    NSString *userId, *userName, *userEmail, *userPic;
    NSMutableArray *userDict;
    
}
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userEmail;
@property (nonatomic, retain) NSString *userPic;
@property (nonatomic, retain) NSMutableArray *userDict;


@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonAction:(id)sender;

@end
