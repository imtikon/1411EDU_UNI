//
//  DetailProfilePhotoViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 1/16/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailProfilePhotoViewController : UIViewController<UIImagePickerControllerDelegate>{
    
    UIImagePickerController *imagePickerController;
    IBOutlet UIImageView *imageView;
    UIImage *imageOfThing;
    
}

@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *uploadPhotoActivity;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;


// --- previous Code

@property(strong) UIImage *img;
@property (weak, nonatomic) IBOutlet UIImageView *traditionImageView;
@property (weak, nonatomic) IBOutlet UILabel *traditionName;
@property (weak, nonatomic) NSString *traditionImageName;
@property (weak, nonatomic) NSString *traditionImageId;

@property (strong, nonatomic) IBOutlet UITextView *traditionImageCaption;


@end
