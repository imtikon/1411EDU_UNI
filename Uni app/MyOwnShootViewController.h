//
//  MyOwnShootViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 1/29/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOwnShootViewController : UIViewController<UIImagePickerControllerDelegate, UITextFieldDelegate>{
    
    UIImagePickerController *imagePickerController;
    IBOutlet UIImageView *imageView;
    UIImage *imageOfThing;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *uploadPhotoActivity;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;

@property (strong, nonatomic) IBOutlet UITextField *traditionNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *eventNameTextField;

- (IBAction)takePhotoAction:(UIButton *)sender;
- (IBAction)uploadPhotoAction:(UIButton *)sender;

- (IBAction)postToTwitter:(id)sender;
- (IBAction)closePhotoWindow;

@end
