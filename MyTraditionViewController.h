//
//  MyTraditionViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MyTraditionViewController : UIViewController<UIImagePickerControllerDelegate>{
    
    UIImagePickerController *imagePickerController;
    IBOutlet UIImageView *imageView;
    UIImage *imageOfThing;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *uploadPhotoActivity;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;

- (IBAction)takePhotoAction:(UIButton *)sender;
- (IBAction)uploadPhotoAction:(UIButton *)sender;

@end
