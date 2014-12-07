//
//  DetailTraditionViewController.h
//  SliderMenu
//
//  Created by Imtiaz Hossain on 11/23/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTraditionViewController : UIViewController<UIImagePickerControllerDelegate>{
    
    UIImagePickerController *imagePickerController;
    IBOutlet UIImageView *imageView;
    UIImage *imageOfThing;
    
}

@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *uploadPhotoActivity;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;

- (IBAction)takePhotoAction:(UIButton *)sender;
- (IBAction)uploadPhotoAction:(UIButton *)sender;



// --- previous Code

    @property(strong) UIImage *img;
    @property (weak, nonatomic) IBOutlet UIImageView *traditionImageView;
    @property (weak, nonatomic) IBOutlet UILabel *traditionName;
    @property (weak, nonatomic) NSString *traditionImageName;
    @property (weak, nonatomic) NSString *traditionImageId;

    @property (strong, nonatomic) IBOutlet UITextView *traditionImageCaption;

    - (IBAction)closeView:(id)sender;

@end
