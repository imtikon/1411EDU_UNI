//
//  RegistrationViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/26/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *graduationTxt;
@property (strong, nonatomic) IBOutlet UIButton *graduationPicker;
//@property (strong, nonatomic) IBOutlet UIPickerView *graduationPicker;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)signUpAction:(id)sender;

//@property (strong, nonatomic) IBOutlet UIPickerView *areaPicker;
//@property (strong, nonatomic) IBOutlet UIImageView *layerImage;
//
//
//@property (strong, nonatomic) IBOutlet UILabel *signupName;
//@property (strong, nonatomic) IBOutlet UILabel *signUpEmail;
//@property (strong, nonatomic) IBOutlet UILabel *signUpPassword;
//@property (strong, nonatomic) IBOutlet UILabel *signUpGraduationYear;

@end
