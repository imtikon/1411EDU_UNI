//
//  MyProfileViewController.h
//  Uni app
//
//  Created by Imtiaz Hossain on 1/16/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyProfileViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate>{
    
    UIImagePickerController *imagePickerController;
    IBOutlet UIImageView *imageView;
    UIImage *imageOfThing;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *myName;
@property (strong, nonatomic) IBOutlet UILabel *myBio;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *uploadPhotoActivity;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;

- (IBAction)takePhotoAction:(UIButton *)sender;
- (IBAction)uploadPhotoAction:(UIButton *)sender;

@end
